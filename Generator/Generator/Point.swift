//
//  Point.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 20/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

struct Point: Equatable {
    let x: Int
    let y: Int
}

func ==(lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
