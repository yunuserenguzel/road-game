//
//  GeneratorUnitTests.swift
//  GeneratorUnitTests
//
//  Created by Yunus Eren Guzel on 21/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import XCTest

class CellUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCell() {
        let point = Point(x: 0, y: 0)
        let cellType: CellType = .active
        let cell = Cell(point: point, cellType: cellType)
        XCTAssertNotNil(cell)
    }
    
//    cell.direction(ofCell:)
    func testCellLocationVerticalNeighbor() {
        let cell1 = Cell(point: Point(x: 0, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 0, y: 1), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), .south)
        XCTAssertEqual(cell2.direction(ofCell: cell1), .north)
    }
    
    func testCellLocationHorizontalNeighbor() {
        let cell1 = Cell(point: Point(x: 0, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 1, y: 0), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), .east)
        XCTAssertEqual(cell2.direction(ofCell: cell1), .west)
    }
    
    func testCellLocationCross() {
        let cell1 = Cell(point: Point(x: 0, y: 1), cellType: .active)
        let cell2 = Cell(point: Point(x: 1, y: 0), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), nil)
        XCTAssertEqual(cell2.direction(ofCell: cell1), nil)
    }
    
    func testCellLocationCrossReverse() {
        let cell1 = Cell(point: Point(x: 1, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 0, y: 1), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), nil)
        XCTAssertEqual(cell2.direction(ofCell: cell1), nil)
    }
    
    func testCellLocationHorizontalDistant() {
        let cell1 = Cell(point: Point(x: 2, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 0, y: 0), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), nil)
        XCTAssertEqual(cell2.direction(ofCell: cell1), nil)
    }
    
    func testCellLocationVerticalDistant() {
        let cell1 = Cell(point: Point(x: 1, y: 10), cellType: .active)
        let cell2 = Cell(point: Point(x: 1, y: 5), cellType: .active)
        XCTAssertEqual(cell1.direction(ofCell: cell2), nil)
        XCTAssertEqual(cell2.direction(ofCell: cell1), nil)
    }
    
    func testCellDisconnectShouldDeleteConnection() {
        let cell1 = Cell(point: Point(x: 1, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 1, y: 1), cellType: .active)
        cell1.connection.south = cell2
        cell2.connection.north = cell1
        cell1.disconnect(fromCell: cell2)
        XCTAssertNil(cell1.connection.south)
        XCTAssertNil(cell2.connection.north)
    }
    
    func testCellConnectToAnotherCell() {
        let cell1 = Cell(point: Point(x: 1, y: 0), cellType: .active)
        let cell2 = Cell(point: Point(x: 1, y: 1), cellType: .active)
        let result = cell1.connect(toCell: cell2)
        XCTAssertEqual(result, true)
        XCTAssertEqual(cell1.connection.south, cell2)
        XCTAssertEqual(cell2.connection.north, cell1)
        XCTAssertEqual(cell1.connection.count, 1)
        XCTAssertEqual(cell2.connection.count, 1)
    }
    
    func testCellCanConnectReturnsFalseAfterConnect() {
        let cell1 = Cell(point: Point(x: 3, y: 2), cellType: .active)
        let cell2 = Cell(point: Point(x: 2, y: 2), cellType: .active)
        XCTAssert(cell1.canConnect(toCell: cell2))
        XCTAssert(cell1.connect(toCell: cell2))
        XCTAssertFalse(cell1.canConnect(toCell: cell2))
    }
    
}




