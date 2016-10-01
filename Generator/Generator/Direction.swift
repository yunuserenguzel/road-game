//
//  Direction.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

enum Direction {
    
    case north, south, west, east
    
}

extension Direction {
    
    var opposite: Direction {
        switch self {
        case .north:
            return .south
        case .south:
            return .north
        case .west:
            return .east
        case .east:
            return .west
        }
    }
    
}
