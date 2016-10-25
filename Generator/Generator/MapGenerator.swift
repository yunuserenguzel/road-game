//
//  MapGenerator.swift
//  Generator
//
//  Created by Yunus Güzel on 25/10/2016.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

class MapGenerator {
    
    let size: Int
    let limit: Int
    
    init(size: Int, limit: Int) {
        self.size = size
        self.limit = limit
    }
    
    func generateMaps() -> [Map] {
        var maps: [Map] = []
        repeat {
            if let map = generateMap(), !maps.contains(map) {
                maps.append(map)
            }
        } while(maps.count < limit)
        return maps
    }
    
    func generateMap() -> Map? {
        let helper = MapGeneratorHelper(map: Map(size: size))
        return helper.execute()
    }
    
}

class MapGeneratorHelper {
    
    var map: Map
    
    init(map: Map) {
        self.map = map.copy
    }
    
    func execute() -> Map? {
        let cell: Cell! = map.cells.shuffled().first?.shuffled().first
        if executeAStep(cell: cell) {
            return map.copy
        }
        return nil
    }
    
    func executeAStep(cell: Cell) -> Bool {
        for direction in Direction.all.shuffled() {
            guard let nextCell = self.map.cell(nextToCell: cell, atDirection: direction) else { continue }
            guard cell.connect(toCell: nextCell) else { continue }
            if map.solved {
                return true
            }
            if nextCell.connection.count < 2, executeAStep(cell: nextCell) {
                return true
            }
        }
        return false
    }
    
}
