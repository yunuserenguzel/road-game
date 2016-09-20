//
//  Benchmark.swift
//  Road
//
//  Created by Yunus Eren Guzel on 17/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation


func bench(description: String = "", block: () -> Void) -> NSTimeInterval {
    let startTime = NSDate()
    block()
    let interval = NSDate().timeIntervalSinceDate(startTime)
    print("\(description) is executed in \(interval * 1000) miliseconds")
    return interval
}