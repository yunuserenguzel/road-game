//
//  MapGenerator.swift
//  Generator
//
//  Created by Yunus Güzel on 25/10/2016.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

public class MapGenerator {
    
    let size: Int
    let limit: Int
    let passiveCellCount: Int
    
    public init(size: Int, limit: Int, passiveCellCount: Int) {
        self.size = size
        self.limit = limit
        self.passiveCellCount = passiveCellCount
    }
    
    public func generateMaps() -> [Map] {
        var maps: [Map] = []
        repeat {
            if let map: Map = generateMap(), !maps.contains(map) {
                maps.append(map)
            }
        } while(maps.count < limit)
        return maps
    }
    
    func generateMap() -> Map? {
        let helper = MapGeneratorHelper(map: Map(size: size))
        return helper.execute()
    }
    
    public func generateMap() -> [(Int,Int)] {
        let map: Map! = generateMap()
        return map.cells.flatMap {
            $0.flatMap {
                return $0.cellType == .passive ? ($0.point.x, $0.point.y) : nil
            }
        }
    }
    
}

class MapGeneratorHelper {
    
    var map: Map
    
    init(map: Map) {
        self.map = map.copy
    }
    
    func execute() -> Map? {
        let cell: Cell! = map.cells.shuffled().first?.shuffled().first
        print("Starting point \(cell.point)")
        if executeAStep(cell: cell) {
            return Map(size: map.size, passiveCellPoints: map.unconnectedPoints)
        }
        return nil
    }
    
    func executeAStep(cell: Cell) -> Bool {
        for direction in Direction.all.shuffled() {
            guard let nextCell = self.map.cell(nextToCell: cell, atDirection: direction) else { continue }
            guard cell.connect(toCell: nextCell) else { continue }
            if nextCell.connection.count == 2 {
                return true
            }
            if executeAStep(cell: nextCell) {
                return true
            }
            cell.disconnect(fromCell: nextCell)
        }
        return false
    }
    
}
