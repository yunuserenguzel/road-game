//
//  MapGeneratorTests.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 25/10/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import XCTest

class MapGeneratorTests: XCTestCase {
    
    func testMapGeneratesMaps() {
        let mapGenerator = MapGenerator(size: 3, limit: 2)
        let maps = mapGenerator.generateMaps()
        XCTAssertEqual(maps.count, 2)
    }
    
    func testMapGenerateUniqueMaps() {
        let mapGenerator = MapGenerator(size: 3, limit: 2)
        let maps = mapGenerator.generateMaps()
        XCTAssertNotEqual(maps.first, maps.last)
    }

}
