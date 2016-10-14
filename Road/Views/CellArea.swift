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
    
    fileprivate(set) var map:Map!
    fileprivate var lastHitCell:CellView!
    
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
        backgroundColor = UIColor.lightGray
        var cellViews = Dictionary<String,UIView>()
        var horizontalFormatStrings = [String]()
        var verticalFormatStrings = [String]()
        for y in (0..<map.size.rows) {
            horizontalFormatStrings.append("")
        }
        for x in (0..<map.size.cols) {
            verticalFormatStrings.append("")
        }
        for y in (0..<map.size.rows) {
            for x in (0..<map.size.cols) {
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
        for y in 0..<map.size.rows {
            let string = String(format: "V:|%@-1-|", verticalFormatStrings[y])
            //            println(string)
            addConstraints(NSLayoutConstraint
                .constraints(withVisualFormat: string, options: [], metrics: nil, views: cellViews))
        }
        for x in 0..<map.size.cols {
            let string = String(format: "H:|%@-1-|", horizontalFormatStrings[x])
            //            println(string)
            addConstraints(NSLayoutConstraint
                .constraints(withVisualFormat: string, options: [], metrics: nil, views: cellViews))
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
    
    func hitCell(_ touch:UITouch, event:UIEvent) -> CellView? {
        for cell in cells {
            if cell.point(inside: touch.location(in: cell), with: event) {
                return cell
            }
        }
        return nil
    }
    
    func hightlightCell(_ currentCell:CellView?) {
        for cell in cells {
            if cell == currentCell {
                cell.state = CellState.hightlighted
            } else {
                cell.state = CellState.normal
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hightlightCell(nil)
        lastHitCell = nil
        checkGame()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hightlightCell(nil)
        lastHitCell = nil
        checkGame()
    }
    
    func snapShot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
