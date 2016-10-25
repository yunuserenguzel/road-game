//
//  MapSolver.swift
//  Generator
//
//  Created by Yunus Güzel on 25/10/2016.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

class MapSolver {
    
    func findSolutions(size: Int, limit: Int = 10) -> [Map] {
        return []
    }
    
    func findSolution() -> Map? {
        return nil
    }

    
}

class MapSolutionHelper {
    
    var map: Map
    
    init(map: Map) {
        self.map = map.copy
    }
    
    func executeWithRandomCell() -> Map? {
        if executeAStep(cell: map.cells.first!.first!) {
            return map.copy
        }
        return nil
    }
    
    func executeAStep(cell: Cell) -> Bool {
        Direction.all.shuffled().forEach { direction in
            nextCell = 
        }
        return false
    }
    
}
