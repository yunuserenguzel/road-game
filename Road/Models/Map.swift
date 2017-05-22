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
    var obstacles: [Point]
    var difficulty: String //change this to enum
    
    static func mapsFrom(groupName: String) -> [Map]? {
        guard let resourcepath = Bundle.main.resourcePath else { return nil }
        guard let mapsGroupURL = URL(string: resourcepath)?.appendingPathComponent("Maps").appendingPathComponent(groupName) else { return nil }
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(atPath: mapsGroupURL.path)
            return directoryContents.flatMap {
                Map(filePath: mapsGroupURL.appendingPathComponent($0).path)
            }
        } catch {
            return nil
        }
    }
    
    convenience init?(filePath: String) {
        do {
            guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? JSON
                else { return nil }
            guard let size = jsonResult["size"] as? Int else { return nil }
            guard let disabledCells = jsonResult["disabled_cells"] as? JSONArray else { return nil }
            let obstacles = disabledCells.map{ Point(x: $0["x"] as! Int, y: $0["y"] as! Int) }
            self.init(difficulty: "", size: Size(cols: size, rows: size), obstacles: obstacles)
        } catch {
            return nil
        }
    }
    
    init(difficulty:String, size:Map.Size, obstacles:[Map.Point]) {
        self.difficulty = difficulty
        self.obstacles = obstacles
        self.size = size
    }
    
    
    func hasBlock(_ point:Point) -> Bool {
        for block in obstacles {
            if block.x == point.x && block.y == point.y {
                return true
            }
        }
        return false
    }
    
}
