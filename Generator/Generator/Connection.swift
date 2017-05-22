//
//  CellDirection.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

struct Connection {
    
    subscript(index: Direction) -> Cell? {
        get {
            return cell(atDirection: index)
        }
        set {
            set(cell: newValue, atDirection: index)
        }
    }
    
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
        case .north:
            return north
        case .south:
            return south
        case .west:
            return west
        case .east:
            return east
        }
    }
    
    mutating func set(cell: Cell?, atDirection direction: Direction) {
        switch direction {
        case .north:
            north = cell
        case .south:
            south = cell
        case .west:
            west = cell
        case .east:
            east = cell
        }
        
    }
    
    func direction(ofCell cell: Cell) -> Direction? {
        if north == cell {
            return .north
        }
        if south == cell {
            return .south
        }
        if west == cell {
            return .west
        }
        if east == cell {
            return .east
        }
        return nil
    }
    
    fileprivate func isEqual(_ connectedCell: Cell?, cell: Cell) -> Bool {
        guard let connectedCell = connectedCell else { return false }
        return connectedCell == cell
    }
    
}
