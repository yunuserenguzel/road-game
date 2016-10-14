//
//  CellView.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

enum CellType {
    case passive, active
}

enum CellState {
    case hightlighted, normal
}

enum Direction {
    case north,south,west,east
}

class CellView: UIView {
    struct Connection {
        var north:CellView?
        var south:CellView?
        var west:CellView?
        var east:CellView?
    }
    
    struct ConnectionView {
        var north = UIView()
        var south = UIView()
        var west = UIView()
        var east = UIView()
    }
    
    var point:Map.Point!
    
    var state:CellState! = CellState.normal {
        didSet {
            configureViews()
        }
    }
    
    var connection:Connection = Connection()
    fileprivate var connectionView:ConnectionView = ConnectionView()
    
    var cellType:CellType! {
        didSet {
            configureViews()
        }
    }
    var label = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        initViews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    func redirectedCellFrom(_ cell:CellView?) -> CellView? {
        if(connection.north != cell && connection.north != nil) {
            return connection.north
        }
        else if (connection.south != cell && connection.south != nil) {
            return connection.south
        }
        else if (connection.west != cell && connection.west != nil) {
            return connection.west
        }
        else if (connection.east != cell && connection.east != nil) {
            return connection.east
        }
        else {
            return nil;
        }
    }
    
    func clearConnections(){
        //    clear any connection for any direction. make the connection nil before calling disconnectFrom
        if let cell = connection.north {
            connection.north = nil
            cell.disconnectFrom(self)
        }
        if let cell = connection.south {
            connection.south = nil
            cell.disconnectFrom(cell)
        }
        if let cell = connection.east {
            connection.east = nil
            cell.disconnectFrom(self)
        }
        if let cell = connection.west {
            connection.west = nil
            cell.disconnectFrom(self)
        }
        configureViews()
    }
    func disconnectFrom(_ cell:CellView) {
        // check for all directions and then call configure views if any connection is set to nil
        if connection.east == cell {
            connection.east = nil
            configureViews()
            if cell.connection.west == self {
                cell.disconnectFrom(self)
            }
        }
        else if connection.north == cell {
            connection.north = nil
            configureViews()
            if cell.connection.south == self {
                cell.disconnectFrom(self)
            }
        }
        else if connection.south == cell {
            connection.south = nil
            configureViews()
            if cell.connection.north == self {
                cell.disconnectFrom(self)
            }
        }
        else if connection.west == cell {
            connection.west = nil
            configureViews()
            if cell.connection.east == self {
                cell.disconnectFrom(self)
            }
        }
    }
    
    
    func connectionCount() -> Int {
        return (connection.west != nil ? 1 : 0) +
            (connection.east != nil ? 1 : 0) +
            (connection.north != nil ? 1 : 0) +
            (connection.south != nil ? 1 : 0)
    }
    
    func connectOrDisconnect(_ cell:CellView) -> Bool {
        if let direction = findDirection(cell) as Direction! {
            var isConnected = false
            switch direction {
            case .north:
                isConnected = self.connection.north == cell
            case .south:
                isConnected = self.connection.south == cell
            case .west:
                isConnected = self.connection.west == cell
            case .east:
                isConnected = self.connection.east == cell
            }
            if isConnected {
                disconnectFrom(cell)
                return true
            } else {
                return connectWith(cell)
            }
        }
        return false
        
    }
    
    func connectWith(_ cell:CellView) -> Bool {
        if connectionCount() > 1 {
            return false
        }
        if let direction = findDirection(cell) as Direction! {
            switch direction {
            case .north:
                connection.north = cell
                if cell.connection.south == nil {
                    cell.connectWith(self)
                }
            case .south:
                connection.south = cell
                if cell.connection.north == nil {
                    cell.connectWith(self)
                }
            case .west:
                connection.west = cell
                if cell.connection.east == nil {
                    cell.connectWith(self)
                }
            case .east:
                connection.east = cell
                if cell.connection.west == nil {
                    cell.connectWith(self)
                }
            }
            configureViews()
            return true
        }
        return false
    }
    func findDirection(_ cell:CellView) -> Direction? {
        
        if cell == self {
            return nil
        }
        if cell.cellType == CellType.passive {
            return nil
        }
        
        if point.x == cell.point.x {
            if point.y == cell.point.y + 1  { // north
                if cell.connectionCount() > 1 && cell.connection.south == nil {
                    return nil
                }
                return Direction.north
            }
            else if point.y + 1 == cell.point.y { // south
                if cell.connectionCount() > 1 && cell.connection.north == nil {
                    return nil
                }
                return Direction.south
            }
        }
        else if point.y == cell.point.y {
            if point.x == cell.point.x + 1 { // west
                if cell.connectionCount() > 1 && cell.connection.east == nil {
                    return nil
                }
                return Direction.west
            }
            else if point.x + 1 == cell.point.x { // east
                if cell.connectionCount() > 1 && cell.connection.west == nil {
                    return nil
                }
                return Direction.east
            }
        }
        return nil
    }
    
    fileprivate func initViews() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        addSubview(label)
        
        connectionView.west.translatesAutoresizingMaskIntoConstraints = false
        connectionView.west.backgroundColor = UIColor.black
        connectionView.west.isHidden = true
        addSubview(connectionView.west)
        
        connectionView.east.translatesAutoresizingMaskIntoConstraints = false
        connectionView.east.backgroundColor = UIColor.black
        connectionView.east.isHidden = true
        addSubview(connectionView.east)
        
        connectionView.north.translatesAutoresizingMaskIntoConstraints = false
        connectionView.north.backgroundColor = UIColor.black
        connectionView.north.isHidden = true
        addSubview(connectionView.north)
        
        connectionView.south.translatesAutoresizingMaskIntoConstraints = false
        connectionView.south.backgroundColor = UIColor.black
        connectionView.south.isHidden = true
        addSubview(connectionView.south)
        
        let views = [
            "label":label,
            "west":connectionView.west,
            "east":connectionView.east,
            "north":connectionView.north,
            "south":connectionView.south
        ]
        let metrics  = [
            "stroke":5
        ]
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|[label]|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|[label]|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-0-[north]-0-[south(north)]-0-|",
                options: NSLayoutFormatOptions.alignAllCenterX, metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: connectionView.north, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:[north(stroke)]", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:[south(stroke)]", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-0-[west]-0-[east(west)]-0-|",
                options: NSLayoutFormatOptions.alignAllCenterY, metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: connectionView.west, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:[west(stroke)]", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:[east(stroke)]", options: [], metrics: metrics, views: views))
    }
    
    func configureViews() {
        if cellType == CellType.active {
            if state == CellState.hightlighted {
                backgroundColor = UIColor.lightGray
            } else {
                backgroundColor = UIColor.white
            }
        } else {
            backgroundColor = UIColor.gray
        }
        connectionView.north.isHidden = connection.north == nil
        connectionView.east.isHidden = connection.east == nil
        connectionView.south.isHidden = connection.south == nil
        connectionView.west.isHidden = connection.west == nil
    }

}
