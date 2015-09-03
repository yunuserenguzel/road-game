//
//  MapSelectionViewController.swift
//  Road
//
//  Created by Yunus Eren Guzel on 03/09/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class MapSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var tableView = UITableView(frame: CGRect.zeroRect, style: UITableViewStyle.Plain)
  var maps = [
    Map(
      difficulty: "Easy",
      size: Map.Size(cols: 4,rows: 4),
      blockGrids: [
        Map.Point(x: 1, y: 1),
        Map.Point(x: 0, y: 3)
      ]),
    Map(
      difficulty: "Moderate",
      size: Map.Size(cols: 6,rows: 6),
      blockGrids: [
        Map.Point(x: 3, y: 0),
        Map.Point(x: 1, y: 3),
        Map.Point(x: 5, y: 3),
        Map.Point(x: 2, y: 5)
      ]),
    Map(
      difficulty: "Hard",
      size: Map.Size(cols: 8,rows: 8),
      blockGrids: [
        Map.Point(x: 4, y: 0),
        Map.Point(x: 2, y: 1),
        Map.Point(x: 0, y: 2),
        Map.Point(x: 6, y: 4),
        Map.Point(x: 5, y: 6),
        Map.Point(x: 2, y: 7)
      ])
  ]
  let mapTableCellIdentifier = "MapCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerClass(MapTableViewCell.classForCoder(), forCellReuseIdentifier: mapTableCellIdentifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
    tableView.estimatedRowHeight = 66
    tableView.rowHeight = UITableViewAutomaticDimension
    view.addSubview(tableView)
    
    view.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|[table]|", options: nil, metrics: nil, views: ["table":tableView]))
    view.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[table]|", options: nil, metrics: nil, views: ["table":tableView]))
    
    
    
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)


  }
    
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(mapTableCellIdentifier, forIndexPath: indexPath) as! MapTableViewCell
    cell.map = maps[indexPath.row]
    return cell
  }
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return maps.count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var viewController =  ViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
    viewController.map = maps[indexPath.row]
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
