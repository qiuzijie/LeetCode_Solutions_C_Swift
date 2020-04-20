//
//  MyTree.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/4/12.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
