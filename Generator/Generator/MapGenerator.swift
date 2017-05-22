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
        let helper = MapGeneratorHelper(map: Map(size: size), passiveCellCount: passiveCellCount)
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
    let passiveCellCount: Int
    
    init(map: Map, passiveCellCount: Int) {
        self.map = map.copy
        self.passiveCellCount = passiveCellCount
    }
    
    func execute() -> Map? {
        let cell: Cell! = map.cells.shuffled().first?.shuffled().first
        if executeAStep(cell: cell) {
            return Map(size: map.size, passiveCellPoints: map.unconnectedPoints)
        }
        return nil
    }
    
    func executeAStep(cell: Cell) -> Bool {
        for direction in Direction.all.shuffled() {
            guard let nextCell = self.map.cell(nextToCell: cell, atDirection: direction) else { continue }
            guard cell.connect(toCell: nextCell) else { continue }
            if map.unconnectedPoints.count == passiveCellCount,
                nextCell.connection.count == 2 {
                return true
            }
            if map.unconnectedPoints.count >= passiveCellCount  {
                if executeAStep(cell: nextCell) {
                    return true
                }
            }
            cell.disconnect(fromCell: nextCell)
        }
        return false
    }
    
}
