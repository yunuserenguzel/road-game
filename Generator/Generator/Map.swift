//
//  Map.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

class Map {
    
    let size: Int
    var cells: [[Cell]] = []
    
    init(size: Int) {
        self.size = size
        cells = (0..<size).map { x in
            return (0..<size).map { y in
                return Cell(point: Point(x:x, y:y), cellType: .active)
            }
        }
    }
    
}
