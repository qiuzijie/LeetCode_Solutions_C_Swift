//
//  MyStack.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/3/7.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation

protocol Stack {
    associatedtype Element

    var isEmpty: Bool { get }
    var size: Int { get }
    var peek: Element? { get }

    mutating func push(_ element: Element);
    mutating func pop() -> Element?;
}

struct stringStack: Stack {
    typealias Element = String
    private var list = [String]()
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    var size: Int {
        return list.count
    }
    var peek: String? {
        return list.last
    }
    
    mutating func push(_ element: String) {
        list.append(element)
    }
    
    mutating func pop() -> String? {
        return list.popLast()
    }
}

struct intStack {

    private var list = [Int]()
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    var size: Int {
        return list.count
    }
    var peek: Int? {
        return list.last
    }
    
    mutating func push(_ element: Int) {
        list.append(element)
    }
    
    mutating func pop() -> Int? {
        return list.popLast()
    }
}
