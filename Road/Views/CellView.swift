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
    var north = false
    var south = false
    var west = false
    var east = false
  }

  var point:Map.Point!
  var state:CellState! = CellState.normal {
    didSet {
      configureViews()
    }
  }
  
  var connection:Connection!
  
  var cellType:CellType! {
    didSet {
      configureViews()
    }
  }
  var label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initViews()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initViews()
  }
  
  func initViews() {
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    label.textAlignment = NSTextAlignment.Center
    self.addSubview(label)
    var views = [
      "label":label
    ]
    self.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[label]|", options: nil, metrics: nil, views: views))
    self.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[label]|", options: nil, metrics: nil, views: views))
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
  }
  
  
  
}
