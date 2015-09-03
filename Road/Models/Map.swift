//
//  Map.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit


class Map: NSObject {
  struct Size {
    var cols:Int
    var rows:Int
  }
  struct Point {
    var x:Int
    var y:Int
  }
  var size:Map.Size
  var blockGrids:Array<Map.Point>
  var difficulty:String //change this to enum
  
  init(difficulty:String,size:Map.Size,blockGrids:Array<Map.Point>) {
    self.difficulty = difficulty
    self.blockGrids = blockGrids
    self.size = size
  }
  func hasBlock(point:Point) -> Bool {
    for block in blockGrids {
      if block.x == point.x && block.y == point.y {
        return true
      }
    }
    return false
  }
  
}
