//
//  MyHeap.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/5/1.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation
// 大顶堆
class Heap {
    public var nums: [Int]
    private var size: Int
    
    public init(size s: Int) {
        nums = [Int]()
        size = s
    }
    
    public init(nums list: [Int]) {
        
        size = list.count
        // 堆化1：插入
//        nums = [Int]()
//        for num in list {
//            insert(num)
//        }
        // 堆化2：从最后一个父节点开始调整
        nums = list
        let finalParIdx = (nums.count-2)/2
        for i in (0...finalParIdx).reversed() {
            Heap.heapify(&nums, i, nums.count-1)
        }
    }
    
    public static func sorted(_ list: [Int]) -> [Int] {
        var k = list.count-1
        var list = list
        Heap.heapify(&list, 0, k)
        while k > 0 {
            list.swapAt(0, k)
            k -= 1
            Heap.heapify(&list, 0, k)
        }
        return list
    }
    
    public func insert(_ num: Int) -> Bool {
        if size == nums.count {
            return false
        }
        nums.append(num)
        
        var curIdx = nums.count-1
        // 自下而上调整
        while curIdx > 0 && nums[(curIdx-1)/2] < nums[curIdx] {
            nums.swapAt((curIdx-1)/2, curIdx)
            curIdx = (curIdx-1)/2
        }
        return true
    }
    
    public func pop() -> Int? {
        let peek = nums.first
        if nums.count > 1 {
            nums[0] = nums.last!
        }
        Heap.heapify(&nums, 0, nums.count-2)
        nums.removeLast()
        return peek
    }
    
    // 自上而下调整 peek bottom
    public static func heapify(_ nums: inout [Int], _ p: Int, _ b: Int) {
        var curIdx = p
        while true {
            let lc = (curIdx+1)*2-1 // 左孩子
            let lr = (curIdx+1)*2 // 右孩子
            var target = curIdx
            if lc <= b && nums[lc] > nums[curIdx] {
                target = lc
            }
            if lr <= b && nums[lr] > nums[target] {
                target = lr
            }
            if target == curIdx {
                break
            } else {
                nums.swapAt(curIdx, target)
                curIdx = target
            }
        }
    }
}
