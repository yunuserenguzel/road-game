//
//  Map.swift
//  Road
//
//  Created by Yunus Eren Guzel on 28/08/15.
//  Copyright (c) 2015 yeg. All rights reserved.
//

import UIKit

typealias JSON = [String: AnyObject]
typealias JSONArray = [JSON]

class Map: NSObject {
    struct Size {
        var cols: Int
        var rows: Int
    }
    struct Point {
        var x: Int
        var y: Int
    }
    var size: Size
    var obstacles: Array<Point>
    var difficulty: String //change this to enum
    
    static func mapsFrom(groupName groupName: String) -> [Map]? {
        guard let resourcepath = NSBundle.mainBundle().resourcePath else { return nil }
        guard let mapsGroupURL = NSURL(string: resourcepath)?.URLByAppendingPathComponent("Maps").URLByAppendingPathComponent(groupName) else { return nil }
        do {
            let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(mapsGroupURL.path!)
            return directoryContents.flatMap {
                Map(filePath: mapsGroupURL.URLByAppendingPathComponent($0).path!)
            }
        } catch {
            return nil
        }
    }
    
    convenience init?(filePath: String) {
        do {
            guard let jsonData = NSData(contentsOfFile: filePath),
                jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? JSON
                else { return nil }
            guard let size = jsonResult["size"] as? Int else { return nil }
            guard let disabledCells = jsonResult["disabled_cells"] as? JSONArray else { return nil }
            let obstacles = disabledCells.map{ Point(x: $0["x"] as! Int, y: $0["y"] as! Int) }
            self.init(difficulty: "", size: Size(cols: size, rows: size), obstacles: obstacles)
        } catch {
            return nil
        }
    }
    
    init(difficulty:String, size:Map.Size, obstacles:Array<Map.Point>) {
        self.difficulty = difficulty
        self.obstacles = obstacles
        self.size = size
    }
    
    
    func hasBlock(point:Point) -> Bool {
        for block in obstacles {
            if block.x == point.x && block.y == point.y {
                return true
            }
        }
        return false
    }
    
}
