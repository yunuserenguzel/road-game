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
  private var connectionView:ConnectionView = ConnectionView()
  
  var cellType:CellType! {
    didSet {
      configureViews()
    }
  }
  var label = UILabel()

  init() {
    super.init(frame: CGRect.zeroRect)
    initViews()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    initViews()
  }
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initViews()
  }
  
  func connectionCount() -> Int {
    return (connection.west != nil ? 1 : 0) +
      (connection.east != nil ? 1 : 0) +
      (connection.north != nil ? 1 : 0) +
      (connection.south != nil ? 1 : 0)
  }
  
  func connectWith(cell:CellView) {
    if connectionCount() > 1 {
      return
    }
    if cell == self {
      return
    }
    if cell.cellType == CellType.passive {
      return
    }
    
    if point.x == cell.point.x {
      if point.y == cell.point.y + 1  { // north
        connection.north = cell
        println("north connection")
        configureViews()
        if cell.connection.south == nil {
          cell.connectWith(self)
        }
      }
      else if point.y + 1 == cell.point.y { // south
        connection.south = cell
        configureViews()
        println("south connection")
        if cell.connection.north == nil {
          cell.connectWith(self)
        }
      }
    }
    else if point.y == cell.point.y {
      if point.x == cell.point.x + 1 { // west
        connection.west = cell
        configureViews()
        println("west connection")
        if cell.connection.east == nil {
          cell.connectWith(self)
        }
      }
      else if point.x + 1 == cell.point.x { // east
        connection.east = cell
        configureViews()
        println("east connection")
        if cell.connection.west == nil {
          cell.connectWith(self)
        }
      }
    }
  }
  
  private func initViews() {
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    label.textAlignment = NSTextAlignment.Center
    addSubview(label)

    connectionView.west.setTranslatesAutoresizingMaskIntoConstraints(false)
    connectionView.west.backgroundColor = UIColor.blackColor()
    connectionView.west.hidden = true
    addSubview(connectionView.west)

    connectionView.east.setTranslatesAutoresizingMaskIntoConstraints(false)
    connectionView.east.backgroundColor = UIColor.blackColor()
    connectionView.east.hidden = true
    addSubview(connectionView.east)

    connectionView.north.setTranslatesAutoresizingMaskIntoConstraints(false)
    connectionView.north.backgroundColor = UIColor.blackColor()
    connectionView.north.hidden = true
    addSubview(connectionView.north)

    connectionView.south.setTranslatesAutoresizingMaskIntoConstraints(false)
    connectionView.south.backgroundColor = UIColor.blackColor()
    connectionView.south.hidden = true
    addSubview(connectionView.south)

    var views = [
      "label":label,
      "west":connectionView.west,
      "east":connectionView.east,
      "north":connectionView.north,
      "south":connectionView.south
    ]
    var metrics  = [
      "stroke":5
    ]
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[label]|", options: nil, metrics: metrics, views: views))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: metrics, views: views))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-0-[north]-0-[south(north)]-0-|",
        options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metrics, views: views))
    addConstraint(NSLayoutConstraint(item: connectionView.north, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:[north(stroke)]", options: nil, metrics: metrics, views: views))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:[south(stroke)]", options: nil, metrics: metrics, views: views))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-0-[west]-0-[east(west)]-0-|",
        options: NSLayoutFormatOptions.AlignAllCenterY, metrics: metrics, views: views))
    addConstraint(NSLayoutConstraint(item: connectionView.west, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:[west(stroke)]", options: nil, metrics: metrics, views: views))
    addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:[east(stroke)]", options: nil, metrics: metrics, views: views))
  }
  
  func configureViews() {
    if cellType == CellType.active {
      if state == CellState.hightlighted {
        backgroundColor = UIColor.lightGrayColor()
      } else {
        backgroundColor = UIColor.whiteColor()
      }
    } else {
      backgroundColor = UIColor.grayColor()
    }
    if connection.north != nil {
      connectionView.north.hidden = false
    }
    if connection.east != nil {
      connectionView.east.hidden = false
    }
    if connection.south != nil {
      connectionView.south.hidden = false
    }
    if connection.west != nil {
      connectionView.west.hidden = false
    }
  }
  
  
  
}
