//
//  Benchmark.swift
//  Road
//
//  Created by Yunus Eren Guzel on 17/09/16.
//  Copyright © 2016 yeg. All rights reserved.
//

import Foundation


func bench(_ description: String = "", block: () -> Void) -> TimeInterval {
    let startTime = Date()
    block()
    let interval = Date().timeIntervalSince(startTime)
    print("\(description) is executed in \(interval * 1000) miliseconds")
    return interval
}
