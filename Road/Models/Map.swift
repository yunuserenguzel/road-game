//
//  Map.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class Map: NSObject {
  
  var blockGrids:Array<CGPoint>
  var size:CGSize
  
  init(size:CGSize,blockGrids:Array<CGPoint>) {
     self.blockGrids = blockGrids
    self.size = size
  }
}
