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
  required init(coder aDecoder: NSCoder) {
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
    mapOverview.setTranslatesAutoresizingMaskIntoConstraints(false)
    contentView.addSubview(mapOverview)
    
    mapDescriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    contentView.addSubview(mapDescriptionLabel)
    
    mapDifficultyLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
    contentView.addSubview(mapDifficultyLabel)
    
    var views = [
      "overview":mapOverview,
      "desc":mapDescriptionLabel,
      "difficulty":mapDifficultyLabel,
      "content":contentView
    ]
    var metrics = [
      "overviewEdge":66.0
    ]
    
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-[overview(overviewEdge)]-[desc]-|", options: nil, metrics: metrics, views: views))
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("H:[overview]-[difficulty]-|", options: nil, metrics: metrics, views: views))
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-[overview(overviewEdge)]", options: nil, metrics: metrics, views: views))
    contentView.addConstraints(NSLayoutConstraint
      .constraintsWithVisualFormat("V:|-[desc(44)][difficulty(22)]-|", options: nil, metrics: metrics, views: views))
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configureViews() {
    var cellArea = CellArea(map: map)
    cellArea.frame = CGRectMake(0, 0, 132, 132)
    UIApplication.sharedApplication().windows[0].addSubview(cellArea)
    cellArea.opaque = true
    self.mapOverview.image = cellArea.snapShot()
    cellArea.removeFromSuperview()
    self.mapDescriptionLabel.text = String(format: "Map Size %d x %d", map.size.cols, map.size.rows)
    self.mapDifficultyLabel.text = String(format: "Difficulty: %@", map.difficulty)
  }

}
