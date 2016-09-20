//
//  Direction.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

enum Direction {
    
    case North, South, West, East
    
}

extension Direction {
    
    var opposite: Direction {
        switch self {
        case .North:
            return .South
        case .South:
            return .North
        case .West:
            return .East
        case .East:
            return .West
        }
    }
    
}