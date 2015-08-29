//
//  ViewController.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let scrollView = UIScrollView()
  var cellArea:CellArea!
  
  var map:Map! {
    didSet {
      generateCellArea()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.whiteColor()
    
    scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
//    scrollView.backgroundColor = UIColor.redColor()
    view.addSubview(scrollView)
    
    var views = [
      "scroll":scrollView
    ]
    
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[scroll]-0-|", options: nil, metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[scroll]-0-|", options: nil, metrics: nil, views: views))
    
  }
  
  func generateCellArea() {
    cellArea = CellArea(map: map)
    cellArea.setTranslatesAutoresizingMaskIntoConstraints(false)
    scrollView.addSubview(cellArea)
    
    var views = [
      "cellArea":cellArea,
      "scroll":scrollView
    ]
    
    scrollView.addConstraints([
      NSLayoutConstraint(item: cellArea, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellArea, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
      ])
    
    scrollView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-0-[cellArea(==scroll)]-0-|", options: nil, metrics: nil, views: views))
    
    scrollView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-20-[cellArea]", options: nil, metrics: nil, views: views))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

