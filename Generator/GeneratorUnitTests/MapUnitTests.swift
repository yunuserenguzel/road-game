//
//  MapUnitTests.swift
//  Generator
//
//  Created by Yunus Eren Guzel on 21/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import XCTest

class MapUnitTests: XCTestCase {

    func testMapMustInitWithSize() {
        let size = 5
        let map = Map(size: size)
        XCTAssertNotNil(map)
        XCTAssertEqual(map.size, size)
    }
    
    func testMapMustHaveNumberOfCellsEqualToSquareOfSize() {
        let map = Map(size: 10)
        let totalNumberOfCells = map.cells.reduce(0) { $0 + $1.count }
        XCTAssertEqual(totalNumberOfCells, map.size * map.size)
    }
    
    func testNumberOfCellConnections() {
        let map = Map(size: 10)
        XCTAssert(map.cells[0][0].connect(toCell: map.cells[0][1]))
        XCTAssertEqual(map.numberOfCellConnections, 1)
    }
    
    
    

}
