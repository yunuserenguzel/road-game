//
//  MapSelectionViewController.swift
//  Road
//
//  Created by Yunus Eren Guzel on 03/09/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class MapSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.Plain)
    let playRandomMapButton = UIButton()
    
    var maps = [Map]() {
        didSet {
            tableView.reloadData()
        }
    }
    
//    var maps = [
//        Map(
//            difficulty: "Easy",
//            size: Map.Size(cols: 4,rows: 4),
//            obstacles: [
//                Map.Point(x: 1, y: 1),
//                Map.Point(x: 0, y: 3)
//            ]),
//        Map(
//            difficulty: "Moderate",
//            size: Map.Size(cols: 6,rows: 6),
//            obstacles: [
//                Map.Point(x: 3, y: 0),
//                Map.Point(x: 1, y: 3),
//                Map.Point(x: 5, y: 3),
//                Map.Point(x: 2, y: 5)
//            ]),
        //    Map(
        //      difficulty: "Hard",
        //      size: Map.Size(cols: 8,rows: 8),
        //      obstacles: [
        //        Map.Point(x: 4, y: 0),
        //        Map.Point(x: 2, y: 1),
        //        Map.Point(x: 0, y: 2),
        //        Map.Point(x: 6, y: 4),
        //        Map.Point(x: 5, y: 6),
        //        Map.Point(x: 2, y: 7)
        //      ]),
        //    Map(
        //      difficulty: "Hard",
        //      size: Map.Size(cols: 8,rows: 8),
        //      obstacles: [
        //        Map.Point(x: 3, y: 0),
        //        Map.Point(x: 5, y: 1),
        //        Map.Point(x: 7, y: 2),
        //        Map.Point(x: 4, y: 4),
        //        Map.Point(x: 5, y: 6),
        //        Map.Point(x: 3, y: 7)
        //      ]),
        //    Map(
        //      difficulty: "Hard",
        //      size: Map.Size(cols: 8,rows: 8),
        //      obstacles: [
        //        Map.Point(x: 1, y: 1),
        //        Map.Point(x: 4, y: 1),
        //        Map.Point(x: 6, y: 2),
        //        Map.Point(x: 0, y: 4),
        //        Map.Point(x: 7, y: 4),
        //        Map.Point(x: 3, y: 6)
        //      ])
//    ]
    let mapTableCellIdentifier = "MapCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(MapTableViewCell.classForCoder(), forCellReuseIdentifier: mapTableCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        
        playRandomMapButton.translatesAutoresizingMaskIntoConstraints = false
        playRandomMapButton.setTitle("Play Random Map", forState: .Normal)
        playRandomMapButton.backgroundColor = UIColor.grayColor()
        playRandomMapButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        playRandomMapButton.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
        playRandomMapButton.addTarget(self, action: "playRandomMap", forControlEvents: .TouchUpInside)
        view.addSubview(playRandomMapButton)
        
        maps = Map.mapsFrom(groupName: "MapSize_8x8_1474150464")!
        
        let views = [
            "table": tableView,
            "random": playRandomMapButton
        ]
        
        view.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("H:|[table]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("V:|[table]|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("H:|[random]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("V:[random(44)]|", options: [], metrics: nil, views: views))
        
    }
    
    func playRandomMap() {
        let randomMapIndex = random() % maps.count
        playMapAtIndex(randomMapIndex)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mapTableCellIdentifier, forIndexPath: indexPath) as! MapTableViewCell
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
        playMapAtIndex(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func playMapAtIndex(index: Int) {
        let gameViewController =  GameViewController()
        self.navigationController?.pushViewController(gameViewController, animated: true)
        gameViewController.map = maps[index]
    }
    
    
}
