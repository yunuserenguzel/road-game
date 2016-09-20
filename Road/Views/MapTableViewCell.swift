//
//  MapTableViewCell.swift
//  Road
//
//  Created by Yunus Eren Guzel on 03/09/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    private let mapOverview = UIImageView()
    private let mapDescriptionLabel = UILabel()
    private let mapDifficultyLabel = UILabel()
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
        mapOverview.contentMode = UIViewContentMode.ScaleAspectFill
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
            .constraintsWithVisualFormat("H:|-[overview(overviewEdge)]-[desc]-|", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("H:[overview]-[difficulty]-|", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("V:|-[overview(overviewEdge)]", options: [], metrics: metrics, views: views))
        contentView.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat("V:|-[desc(44)][difficulty(22)]-|", options: [], metrics: metrics, views: views))
    }
    
    func configureViews() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
                var cellArea: GridView!
                bench("GridView") {
                    cellArea = GridView(map: self.map)
                }
                cellArea.frame = CGRectMake(0, 0, 164, 164)
                cellArea.setNeedsLayout()
                cellArea.layoutIfNeeded()
            dispatch_async(dispatch_get_main_queue()) {
                cellArea.opaque = true
                let snapshot = cellArea.snapShot()
                self.mapOverview.image = snapshot
            }
            
        }
        self.mapDescriptionLabel.text = String(format: "Map Size %d x %d", map.size.cols, map.size.rows)
        self.mapDifficultyLabel.text = String(format: "Difficulty: %@", map.difficulty)
    }
    
}
