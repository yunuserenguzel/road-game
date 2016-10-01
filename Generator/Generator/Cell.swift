//
//  Cell.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

class Cell: NSObject {
    
    let point: Point
    let cellType: CellType
    var connection: Connection = Connection()
    
    init(point: Point, cellType: CellType) {
        self.point = point
        self.cellType = cellType
    }
    
    
    func canConnect(toCell cell: Cell) -> Bool {
        guard connection.count < 2 else { return false }
        guard cell.connection.count < 2 else { return false }
        
        return true
    }
    
    func connect(toCell cell: Cell) -> Bool {
        return false
    }
    
    func disconnect(fromCell cell: Cell) {
        guard let direction = connection.direction(ofCell: cell) else { return }
        connection.set(cell: nil, atDirection: direction)
        cell.connection.set(cell: nil, atDirection: direction.opposite)
    }
    
    func location(ofCell cell: Cell) -> Direction? {
        if point.y == cell.point.y {
            if point.x + 1 == cell.point.x {
                return .East
            }
            if point.x == cell.point.x + 1 {
                return .West
            }
        }
        if point.x == cell.point.x {
            if point.y + 1 == cell.point.y {
                return .South
            }
            if point.y == cell.point.y + 1 {
                return .North
            }
        }
        return nil
    }
    
}






























