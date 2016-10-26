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
    
    func testMapMustInitWithPassiveCellPoints() {
        let size = 5
        let passivePoints = [Point(x: 2, y: 1), Point(x: 4, y: 3)]
        let map = Map(size: size, passiveCellPoints: passivePoints)
        XCTAssertEqual(map[2][1]?.cellType, .passive)
        XCTAssertEqual(map[4][3]?.cellType, .passive)
        XCTAssertEqual(map[0][0]?.cellType, .active)
        XCTAssertEqual(map[4][4]?.cellType, .active)
        XCTAssertEqual(map[2][3]?.cellType, .active)
        XCTAssertEqual(map[1][2]?.cellType, .active)
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
    
    func testMapSubscript() {
        let map = Map(size: 10)
        let x = 4
        let y = 6
        let cell = map[x][y]
        XCTAssertEqual(cell?.point, Point(x: x, y: y))
    }
    
    func testCellAtDirection() {
        let map = Map(size: 10)
        let cell: Cell! = map[2][2]
        XCTAssertEqual(map.cell(nextToCell: cell, atDirection: .north)?.point, Point(x: 2, y: 1))
        XCTAssertEqual(map.cell(nextToCell: cell, atDirection: .south)?.point, Point(x: 2, y: 3))
        XCTAssertEqual(map.cell(nextToCell: cell, atDirection: .west)?.point, Point(x: 1, y: 2))
        XCTAssertEqual(map.cell(nextToCell: cell, atDirection: .east)?.point, Point(x: 3, y: 2))
    }

    func testMapsEqual() {
        let map1 = Map(size: 10)
        let map2 = Map(size: 10)
        XCTAssertEqual(map1, map2)
    }
    
    func testMapsNotEqualBySize() {
        let map1 = Map(size: 5)
        let map2 = Map(size: 10)
        XCTAssertNotEqual(map1, map2)
    }
    
    func testMapsNotEqualByCells() {
        let map1 = Map(size: 10)
        let map2 = Map(size: 10)
        map1[4][3]?.cellType = .passive
        XCTAssertNotEqual(map1, map2)
    }
    
    func testUnconnectedPoints() {
        let map = Map(size: 4)
        let points = [
            Point(x: 0, y: 0),
            Point(x: 0, y: 1),
            Point(x: 0, y: 2),
            Point(x: 1, y: 2),
            Point(x: 1, y: 3),
            Point(x: 2, y: 3),
            Point(x: 2, y: 2),
            Point(x: 2, y: 1),
            Point(x: 3, y: 1),
            Point(x: 3, y: 0),
            Point(x: 2, y: 0),
            Point(x: 1, y: 0)
        ]
        for i in points.indices {
            let currentPoint = points[i]
            let nextPoint = points[(i+1) % points.count]
            let currentCell = map[currentPoint.x][currentPoint.y]!
            let nextCell = map[nextPoint.x][nextPoint.y]!
            let _ = currentCell.connect(toCell: nextCell)
        }
        let expectedPassiveCells = [
            Point(x: 0, y: 3),
            Point(x: 1, y: 1),
            Point(x: 3, y: 2),
            Point(x: 3, y: 3)
        ]
        XCTAssertEqual(map.unconnectedPoints, expectedPassiveCells)
    }
    
}
