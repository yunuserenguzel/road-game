//
//  ViewController.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, CellAreaDelegate {
  
  var gridView: GridView!
  var resetButton = UIButton()
  
  var map:Map! {
    didSet {
      generateCellArea()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.edgesForExtendedLayout = UIRectEdge();

    view.backgroundColor = UIColor.white
    
    resetButton.translatesAutoresizingMaskIntoConstraints = false
    resetButton.setTitleColor(UIColor.black, for: UIControlState())
    resetButton.setTitle("Reset", for: UIControlState())
    resetButton.backgroundColor = UIColor.lightGray
    resetButton.addTarget(self, action: #selector(GameViewController.reset), for: UIControlEvents.touchUpInside)
    view.addSubview(resetButton)
    
    let views = [
      "reset":resetButton
    ]
    
    view.addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "H:|[reset]|", options: [], metrics: nil, views: views))
    view.addConstraints(NSLayoutConstraint
      .constraints(withVisualFormat: "V:[reset(44)]-0-|", options: [], metrics: nil, views: views))
  }
  
  func reset() {
//    cellArea.removeFromSuperview()
//    cellArea = nil
//    generateCellArea()
    gridView.resetGame()
  }
  
  func generateCellArea() {
    gridView = GridView(map: map)
    let edge = min(view.frame.size.width, view.frame.size.height)
    gridView.frame = CGRect(x: 0, y: 20, width: edge, height: edge)
    
    view.addSubview(gridView)
    
//    cellArea.setTranslatesAutoresizingMaskIntoConstraints(false)
//    var views = [
//      "cellArea":cellArea
//    ]
//    
//    view.addConstraints([
//      NSLayoutConstraint(item: cellArea, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: cellArea, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
//      ])
//    
//    view.addConstraints(NSLayoutConstraint
//      .constraintsWithVisualFormat("H:|-0-[cellArea]-0-|", options: nil, metrics: nil, views: views))
//    
//    view.addConstraints(NSLayoutConstraint
//      .constraintsWithVisualFormat("V:|-20-[cellArea]", options: nil, metrics: nil, views: views))
    
    gridView.delegate = self
  }
  
  func gameCompleted() {
    let alert = UIAlertController(title: "Congratulations!", message: "Game Completed Successfully.", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "Thanks!", style: UIAlertActionStyle.default, handler: { (asd) -> Void in
      self.navigationController?.popViewController(animated: true)
    }))
    self.present(alert, animated: true, completion: nil)
  }
    
  func exit() {}
  
}

