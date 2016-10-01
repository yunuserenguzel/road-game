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
        let cellType: CellType = .Active
        let cell = Cell(point: point, cellType: cellType)
        XCTAssertNotNil(cell)
    }
    
//    cell.location(ofCell:)
    func testCellLocationVerticalNeighbor() {
        let cell1 = Cell(point: Point(x: 0, y: 0), cellType: .Active)
        let cell2 = Cell(point: Point(x: 0, y: 1), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), .South)
        XCTAssertEqual(cell2.location(ofCell: cell1), .North)
    }
    
    func testCellLocationHorizontalNeighbor() {
        let cell1 = Cell(point: Point(x: 0, y: 0), cellType: .Active)
        let cell2 = Cell(point: Point(x: 1, y: 0), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), .East)
        XCTAssertEqual(cell2.location(ofCell: cell1), .West)
    }
    
    func testCellLocationCross() {
        let cell1 = Cell(point: Point(x: 0, y: 1), cellType: .Active)
        let cell2 = Cell(point: Point(x: 1, y: 0), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), nil)
        XCTAssertEqual(cell2.location(ofCell: cell1), nil)
    }
    
    func testCellLocationCrossReverse() {
        let cell1 = Cell(point: Point(x: 1, y: 0), cellType: .Active)
        let cell2 = Cell(point: Point(x: 0, y: 1), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), nil)
        XCTAssertEqual(cell2.location(ofCell: cell1), nil)
    }
    
    func testCellLocationHorizontalDistant() {
        let cell1 = Cell(point: Point(x: 2, y: 0), cellType: .Active)
        let cell2 = Cell(point: Point(x: 0, y: 0), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), nil)
        XCTAssertEqual(cell2.location(ofCell: cell1), nil)
    }
    
    func testCellLocationVerticalDistant() {
        let cell1 = Cell(point: Point(x: 1, y: 10), cellType: .Active)
        let cell2 = Cell(point: Point(x: 1, y: 5), cellType: .Active)
        XCTAssertEqual(cell1.location(ofCell: cell2), nil)
        XCTAssertEqual(cell2.location(ofCell: cell1), nil)
    }
    
//    cell.disconnect(cell:)
    
    func testCellDisconnectShouldDeleteConnection() {
        let cell1 = Cell(point: Point(x: 1, y: 0), cellType: .Active)
        let cell2 = Cell(point: Point(x: 1, y: 1), cellType: .Active)
        cell1.connection.south = cell2
        cell2.connection.north = cell1
        cell1.disconnect(fromCell: cell2)
        XCTAssertNil(cell1.connection.south)
        XCTAssertNil(cell2.connection.north)
    }
    
}
