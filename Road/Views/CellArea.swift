//
//  CellArea.swift
//  Road
//
//  Created by Yunus Eren Guzel on 29/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class CellArea: UIView {
  private(set) var map:Map!
  private var lastHitCell:CellView!
  
  var cells = [CellView]()
  
  init(map:Map) {
    super.init(frame: CGRect.zeroRect)
    self.map = map
    initViews()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initViews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initViews()
  }
  
  func initViews() {
    backgroundColor = UIColor.lightGrayColor()
    var cellViews = Dictionary<String,UIView>()
    var horizontalFormatStrings = [String]()
    var verticalFormatStrings = [String]()
    for(var y=0; y<map.size.rows; y++) {
      horizontalFormatStrings.append("")
    }
    for(var x=0; x<map.size.cols; x++) {
      verticalFormatStrings.append("")
    }
    for(var x=0; x < map.size.cols; x++) {
      for(var y=0; y < map.size.rows; y++) {
        var cell = CellView()
        cell.point = Map.Point(x: x, y: y)
        if map.hasBlock(cell.point) {
          cell.cellType = CellType.passive
        } else {
          cell.cellType = CellType.active
        }
        cell.setTranslatesAutoresizingMaskIntoConstraints(false)
        var cellString = String(format: "Cell_x%d_y%d",x,y)
        cellViews[cellString] = cell
        cells.append(cell)
        addSubview(cell)
        horizontalFormatStrings[y] += String(format:"-1-[%@(Cell_x0_y%d)]",cellString,x)
        verticalFormatStrings[x] += String(format: "-1-[%@(Cell_x%d_y0)]",cellString,y)
      }
    }
    for(var y=0; y<map.size.rows; y++) {
      var string = String(format: "V:|%@-1-|", verticalFormatStrings[y])
      //      println(string)
      addConstraints(NSLayoutConstraint
        .constraintsWithVisualFormat(string, options: nil, metrics: nil, views: cellViews))
    }
    for(var x=0; x<map.size.cols; x++) {
      var string = String(format: "H:|%@-1-|", horizontalFormatStrings[x])
      //      println(string)
      addConstraints(NSLayoutConstraint
        .constraintsWithVisualFormat(string, options: nil, metrics: nil, views: cellViews))
    }

  }
  func hitCell(touch:UITouch, event:UIEvent) -> CellView? {
    for cell in cells {
      if cell.pointInside(touch.locationInView(cell), withEvent: event) {
        return cell
      }
    }
    return nil
  }
  
  func hightlightCell(currentCell:CellView?) {
    for cell in cells {
      if cell == currentCell {
        cell.state = CellState.hightlighted
      } else {
        cell.state = CellState.normal
      }
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    var touch = touches.first as! UITouch
    if let cell = hitCell(touch, event: event) {
      if cell.cellType == CellType.active {
        hightlightCell(cell)
        lastHitCell = cell
      } else {
        hightlightCell(nil)
      }
    }
  }
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    var touch = touches.first as! UITouch
    if let cell = hitCell(touch, event: event) {
      if cell.cellType == CellType.active {
        hightlightCell(cell)
        if lastHitCell != nil {
          lastHitCell.connectWith(cell)
          
        }
        lastHitCell = cell
      } else {
        hightlightCell(nil)
      }
    }
  }
  override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
    hightlightCell(nil)
    lastHitCell = nil
  }
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    hightlightCell(nil)
    lastHitCell = nil
  }
  
}
