//
//  Map.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

struct MapSubscriptProxy {

    var map: Map
    var mapIndex: Int
    var cells: [Cell]
    var newCell: Cell?
    var newCellIndex: Int?
    
    init(map: Map, mapIndex: Int, cells: [Cell]) {
        self.map = map
        self.mapIndex = mapIndex
        self.cells = cells
    }
    
    subscript(index: Int) -> Cell? {
        get {
            guard cells.indices.contains(index) else { return nil }
            return cells[index]
        }
        set {
            newCell = newValue
            newCellIndex = index
            map[mapIndex] = self
        }
    }
    
}

class Map: Equatable {
    
    subscript(index: Int) -> MapSubscriptProxy {
        get {
            let forwardCells: [Cell] = cells.indices.contains(index) ? cells[index] : []
            return MapSubscriptProxy(map: self, mapIndex: index, cells: forwardCells)
        }
        set {
            guard let newCell = newValue.newCell,
                let newCellIndex = newValue.newCellIndex else { return }
            cells[newValue.mapIndex][newCellIndex] = newCell
        }
    }
    
    let size: Int
    var cells: [[Cell]]
    
    var numberOfCellConnections: Int {
        return cells.reduce(0) {
            $0 + $1.reduce(0) {
                $0 + $1.connection.count
            }
        } / 2
    }
    
    var unconnectedPoints: [Point] {
        return cells.flatMap {
            $0.flatMap {
                $0.connection.count == 0 ? $0.point : nil
            }
        }
    }
    
    init(size: Int, passiveCellPoints: [Point] = []) {
        self.size = size
        cells = (0..<size).map { x in
            return (0..<size).map { y in
                let point = Point(x:x, y:y)
                let type: CellType = passiveCellPoints.contains(point) ? .passive : .active
                return Cell(point: point, cellType: type)
            }
        }
    }
    
    var copy: Map {
        let map = Map(size: size)
        cells.indices.forEach { x in
            self.cells[x].indices.forEach { y in
                map.cells[x][y] = self.cells[x][y].copy
            }
        }
        return map
    }
    
    func cell(nextToCell cell: Cell, atDirection direction: Direction) -> Cell? {
        switch direction {
        case .north:
            return self[cell.point.x][cell.point.y - 1]
        case .south:
            return self[cell.point.x][cell.point.y + 1]
        case .west:
            return self[cell.point.x - 1][cell.point.y]
        case .east:
            return self[cell.point.x + 1][cell.point.y]
        }
    }
    
}

func ==(lhs: Map, rhs: Map) -> Bool {
    guard lhs.size == rhs.size else { return false }
    for x in 0..<lhs.size {
        for y in 0..<lhs.size {
            if lhs[x][y] != rhs[x][y] {
                return false
            }
        }
    }
    return true
}


