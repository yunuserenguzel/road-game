//
//  main.swift
//  Generator
//
//  Created by Yunus Güzel on 25/10/2016.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation

let generator = MapGenerator(size: 8, limit: 1, passiveCellCount: 8)
let map = generator.generateMaps().first

if let map = map {
    print(map)
}
