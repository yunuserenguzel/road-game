//
//  MapSelectionViewController.swift
//  Road
//
//  Created by Yunus Eren Guzel on 03/09/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit
import MapGenerator

class MapSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
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
        tableView.register(MapTableViewCell.classForCoder(), forCellReuseIdentifier: mapTableCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        
        playRandomMapButton.translatesAutoresizingMaskIntoConstraints = false
        playRandomMapButton.setTitle("Play Random Map", for: UIControlState())
        playRandomMapButton.backgroundColor = UIColor.gray
        playRandomMapButton.setTitleColor(UIColor.white, for: UIControlState())
        playRandomMapButton.setTitleColor(UIColor.darkGray, for: .highlighted)
        playRandomMapButton.addTarget(self, action: #selector(MapSelectionViewController.playRandomMap), for: .touchUpInside)
        view.addSubview(playRandomMapButton)
        
        maps = Map.mapsFrom(groupName: "MapSize_8x8_1474150464")!
        
        let views = [
            "table": tableView,
            "random": playRandomMapButton
        ]
        
        view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|[table]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|[table]|", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|[random]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:[random(44)]|", options: [], metrics: nil, views: views))
        
    }
    
    func playRandomMap() {
        DispatchQueue.global().async {
            let size = 8
            let generator = MapGenerator(size: size, limit: 1)
            let obstacles: [Map.Point] = generator.generateMap().map { Map.Point(x: $0.0, y: $0.1) }
            let map = Map(difficulty: "random", size: Map.Size(cols: size, rows: size), obstacles: obstacles)
            DispatchQueue.main.async {
                if self.navigationController?.visibleViewController == self {
                    self.play(map: map)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mapTableCellIdentifier, for: indexPath) as! MapTableViewCell
        cell.map = maps[(indexPath as NSIndexPath).row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maps.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playMapAtIndex((indexPath as NSIndexPath).row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func playMapAtIndex(_ index: Int) {
        play(map: maps[index])
    }
    
    func play(map: Map) {
        let gameViewController =  GameViewController()
        self.navigationController?.pushViewController(gameViewController, animated: true)
        gameViewController.map = map
    }
    
}
