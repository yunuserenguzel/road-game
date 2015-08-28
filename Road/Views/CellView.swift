//
//  CellView.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

enum CellType {
  
}

class CellView: UIView {
  
  var cellType:CellType!
  
  struct connection {
    var north = false
    var south = false
    var west = false
    var east = false
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
