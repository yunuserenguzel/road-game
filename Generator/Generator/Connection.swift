//
//  CellDirection.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

struct Connection {
    
    var north: Cell?
    var south: Cell?
    var west: Cell?
    var east: Cell?
    
    var array: [Cell?] {
        return [north, south, west, east]
    }
    
    var count: Int {
        return array.reduce(0) { $0 + ($1 != nil ? 1 : 0) }
    }
    
    func cell(atDirection direction: Direction) -> Cell? {
        switch direction {
        case .North:
            return north
        case .South:
            return south
        case .West:
            return west
        case .East:
            return east
        }
    }
    
    mutating func set(cell cell: Cell?, atDirection direction: Direction) {
        switch direction {
        case .North:
            north = cell
        case .South:
            south = cell
        case .West:
            west = cell
        case .East:
            east = cell
        }
        
    }
    
    func direction(ofCell cell: Cell) -> Direction? {
        if north == cell {
            return .North
        }
        if south == cell {
            return .South
        }
        if west == cell {
            return .West
        }
        if east == cell {
            return .East
        }
        return nil
    }
    
    private func isEqual(connectedCell: Cell?, cell: Cell) -> Bool {
        guard let connectedCell = connectedCell else { return false }
        return connectedCell == cell
    }
    
}
