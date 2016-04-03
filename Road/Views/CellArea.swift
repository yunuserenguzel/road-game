//
//  CellArea.swift
//  Road
//
//  Created by Yunus Eren Guzel on 29/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

protocol CellAreaDelegate {
    func gameCompleted()
}

class GridView: UIView {
    
    private(set) var map:Map!
    private var lastHitCell:CellView!
    
    var cells = [CellView]()
    
    var delegate:CellAreaDelegate?
    
    init(map:Map) {
        super.init(frame: CGRect.zero)
        self.map = map
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    func initViews() {
        backgroundColor = UIColor.lightGrayColor()
        var cellViews = Dictionary<String,UIView>()
        var horizontalFormatStrings = [String]()
        var verticalFormatStrings = [String]()
        for(var y=0; y<map.size.rows; y++) {
            horizontalFormatStrings.append("")
        }
        for(var x=0; x<map.size.cols; x++) {
            verticalFormatStrings.append("")
        }
        for(var y=0; y < map.size.rows; y++) {
            for(var x=0; x < map.size.cols; x++) {
                let cell = CellView()
                cell.point = Map.Point(x: x, y: y)
                if map.hasBlock(cell.point) {
                    cell.cellType = CellType.passive
                } else {
                    cell.cellType = CellType.active
                }
                cell.translatesAutoresizingMaskIntoConstraints = false
                let cellString = String(format: "Cell_x%d_y%d",x,y)
                //        cell.label.text = String(format: "%d:%d", x,y)
                cellViews[cellString] = cell
                cells.append(cell)
                addSubview(cell)
                horizontalFormatStrings[y] += String(format:"-1-[%@(Cell_x0_y%d)]",cellString,x)
                verticalFormatStrings[x] += String(format: "-1-[%@(Cell_x%d_y0)]",cellString,y)
            }
        }
        for(var y=0; y<map.size.rows; y++) {
            let string = String(format: "V:|%@-1-|", verticalFormatStrings[y])
            //            println(string)
            addConstraints(NSLayoutConstraint
                .constraintsWithVisualFormat(string, options: [], metrics: nil, views: cellViews))
        }
        for(var x=0; x<map.size.cols; x++) {
            let string = String(format: "H:|%@-1-|", horizontalFormatStrings[x])
            //            println(string)
            addConstraints(NSLayoutConstraint
                .constraintsWithVisualFormat(string, options: [], metrics: nil, views: cellViews))
        }
    }
    
    func checkGame() {
        for cell in cells {
            if cell.cellType == CellType.active {
                if cell.connectionCount() != 2 {
                    return
                }
            }
        }
        var firstCell:CellView!
        for cell in cells {
            if cell.cellType == CellType.active {
                firstCell = cell
                break;
            }
        }
        var currentCell:CellView? = firstCell
        var previousCell:CellView? = nil
        var count = 1
        while let cell = currentCell?.redirectedCellFrom(previousCell) {
            if cell == firstCell {
                break;
            }
            previousCell = currentCell
            currentCell = cell
            count += 1
        }
        if count + map.obstacles.count == map.size.cols*map.size.rows {
            self.delegate?.gameCompleted()
        }
    }
    
    func resetGame() {
        for cell in cells {
            cell.clearConnections()
        }
    }
    
    func hitCell(touch:UITouch, event:UIEvent) -> CellView? {
        for cell in cells {
            if cell.pointInside(touch.locationInView(cell), withEvent: event) {
                return cell
            }
        }
        return nil
    }
    
    func hightlightCell(currentCell:CellView?) {
        for cell in cells {
            if cell == currentCell {
                cell.state = CellState.hightlighted
            } else {
                cell.state = CellState.normal
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        if let cell = hitCell(touch, event: event!) {
            if cell.cellType == CellType.active {
                hightlightCell(cell)
                lastHitCell = cell
            } else {
                hightlightCell(nil)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        if let cell = hitCell(touch, event: event!) {
            if cell.cellType == CellType.active {
                hightlightCell(cell)
                if lastHitCell != nil {
                    if lastHitCell.connectOrDisconnect(cell) {
                        lastHitCell = cell
                    }
                }
            } else {
                hightlightCell(nil)
            }
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        hightlightCell(nil)
        lastHitCell = nil
        checkGame()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hightlightCell(nil)
        lastHitCell = nil
        checkGame()
    }
    
    func snapShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
