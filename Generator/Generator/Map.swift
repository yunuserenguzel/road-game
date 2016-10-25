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
    var cellToBeSet: Cell?
    
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
            cellToBeSet = newValue
            map[mapIndex] = self
        }
    }
    
}

class Map {
    
    subscript(index: Int) -> MapSubscriptProxy {
        get {
            let cells: [Cell] = cells.indices.contains(index) ? cells[index] : []
            return MapSubscriptProxy(map: self, mapIndex: index, cells: cells)
        }
        set {
            
        }
    }
    
    let size: Int
    var cells: [[Cell]] = []
    
    var numberOfCellConnections: Int {
        return cells.reduce(0) {
            $0 + $1.reduce(0) {
                $0 + $1.connection.count
            }
        } / 2
    }
    
    init(size: Int) {
        self.size = size
        cells = (0..<size).map { x in
            return (0..<size).map { y in
                return Cell(point: Point(x:x, y:y), cellType: .active)
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
        
        return nil
    }
    
}
