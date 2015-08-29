//
//  CellArea.swift
//  Road
//
//  Created by Yunus Eren Guzel on 29/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class CellArea: UIView {
  var map:Map {
    get {
      return _map
    }
  }
  
  private var _map:Map!
  var cells = [CellView]()
  
  init(map:Map) {
    super.init(frame: CGRect.zeroRect)
    _map = map
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
    var cellViews = Dictionary<String,UIView>()
    var horizontalFormatStrings = [String]()
    var verticalFormatStrings = [String]()
    for(var y=0; y<map.size.rows; y++) {
      horizontalFormatStrings.append("")
    }
    for(var x=0; x<map.size.cols; x++) {
      verticalFormatStrings.append("")
    }
    for(var x=0; x<map.size.cols; x++) {
      for(var y=0; y<map.size.rows; y++) {
        var cell = CellView()
        cell.point = Map.Point(x: x, y: y)
        if map.hasBlock(cell.point) {
          cell.cellType = CellType.passive
        } else {
          cell.cellType = CellType.active
        }
        cell.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.label.text = String(format: "%d:%d",x,y)

        var cellString = String(format: "Cell_x%d_y%d",x,y)
        cellViews[cellString] = cell
        cells.append(cell)
        addSubview(cell)
        horizontalFormatStrings[x] += String(format:"-1-[%@(Cell_x%d_y0)]",cellString,x)
        verticalFormatStrings[y] += String(format: "-1-[%@(Cell_x0_y%d)]",cellString,y)
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
  
  func hightlightCell(currentCell:CellView) {
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
      hightlightCell(cell)
    }
  }
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    var touch = touches.first as! UITouch
    if let cell = hitCell(touch, event: event) {
      cell.state = CellState.hightlighted
      hightlightCell(cell)
    }
  }
  override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
    
  }
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    
  }
  
}
