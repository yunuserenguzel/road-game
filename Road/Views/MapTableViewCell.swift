//
//  MapTableViewCell.swift
//  Road
//
//  Created by Yunus Eren Guzel on 03/09/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    fileprivate let mapOverview = UIImageView()
    fileprivate let mapDescriptionLabel = UILabel()
    fileprivate let mapDifficultyLabel = UILabel()
    var map:Map! {
        didSet {
            configureViews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    func initViews() {
        mapOverview.contentMode = UIViewContentMode.scaleAspectFill
        mapOverview.clipsToBounds = true
        mapOverview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapOverview)
        
        mapDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapDescriptionLabel)
        
        mapDifficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapDifficultyLabel)
        
        let views = [
            "overview":mapOverview,
            "desc":mapDescriptionLabel,
            "difficulty":mapDifficultyLabel,
            "content":contentView
        ]
        let metrics = [
            "overviewEdge":66.0
        ]
        
        contentView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:|-[overview(overviewEdge)]-[desc]-|", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "H:[overview]-[difficulty]-|", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-[overview(overviewEdge)]", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraints(withVisualFormat: "V:|-[desc(44)][difficulty(22)]-|", options: [], metrics: metrics, views: views))
    }
    
    func configureViews() {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async { () -> Void in
            
                var cellArea: GridView!
                bench("GridView") {
                    cellArea = GridView(map: self.map)
                }
                cellArea.frame = CGRect(x: 0, y: 0, width: 164, height: 164)
                cellArea.setNeedsLayout()
                cellArea.layoutIfNeeded()
            DispatchQueue.main.async {
                cellArea.isOpaque = true
                let snapshot = cellArea.snapShot()
                self.mapOverview.image = snapshot
            }
            
        }
        self.mapDescriptionLabel.text = String(format: "Map Size %d x %d", map.size.cols, map.size.rows)
        self.mapDifficultyLabel.text = String(format: "Difficulty: %@", map.difficulty)
    }
    
}
