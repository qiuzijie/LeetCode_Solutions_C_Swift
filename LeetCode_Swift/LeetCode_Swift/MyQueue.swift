//
//  MyQueue.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/3/7.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation
//
//protocol Queue {
//    associatedtype Element
//    var isEmpty: Bool { get }
//    var head: Element? { get }
//    var size: Int { get }
//
//    mutating func enQueue(_ element: Element)
//    mutating func deQueue() -> Element?
//
//}

struct intQueue {
    var isEmpty: Bool {
        return list.isEmpty
    }
    var head: Int? {
        return list.first
    }
    var size: Int {
        return list.count
    }
    private var list = [Int]()
    
    mutating func enQueue(_ element: Int) {
        list.append(element)
    }
    
    mutating func deQueue() -> Int? {
        return list.removeFirst()
    }
    
}
