//
//  Cell.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

class Cell: Equatable {
    
    let point: Point
    var cellType: CellType
    var connection: Connection = Connection()
    
    var copy: Cell {
        let cell = Cell(point: point, cellType: cellType)
        return cell
    }
    
    init(point: Point, cellType: CellType) {
        self.point = point
        self.cellType = cellType
    }
    
    func canConnect(toCell cell: Cell) -> Bool {
        guard connection.count < 2 else { return false }
        guard cell.connection.count < 2 else { return false }
        guard self.cellType == .active, cell.cellType == .active else { return false }
        guard let directionOfCell = direction(ofCell: cell),
            connection.cell(atDirection: directionOfCell) == nil else { return false }
        guard let directionOfSelf = cell.direction(ofCell: self),
            cell.connection.cell(atDirection: directionOfSelf) == nil else { return false }
        return true
    }
    
    func connect(toCell cell: Cell) -> Bool {
        guard canConnect(toCell: cell) else { return false }
        guard let direction = direction(ofCell: cell) else { return false }
        self.connection.set(cell: cell, atDirection: direction)
        cell.connection.set(cell: self, atDirection: direction.opposite)
        return true
    }
    
    func disconnect(fromCell cell: Cell) {
        guard let direction = connection.direction(ofCell: cell) else { return }
        connection.set(cell: nil, atDirection: direction)
        cell.connection.set(cell: nil, atDirection: direction.opposite)
    }
    
    func direction(ofCell cell: Cell) -> Direction? {
        if point.y == cell.point.y {
            if point.x + 1 == cell.point.x {
                return .east
            }
            if point.x == cell.point.x + 1 {
                return .west
            }
        }
        if point.x == cell.point.x {
            if point.y + 1 == cell.point.y {
                return .south
            }
            if point.y == cell.point.y + 1 {
                return .north
            }
        }
        return nil
    }
    
}

func ==(lhs: Cell, rhs: Cell) -> Bool {
    return lhs.point == rhs.point && lhs.cellType == rhs.cellType
}
