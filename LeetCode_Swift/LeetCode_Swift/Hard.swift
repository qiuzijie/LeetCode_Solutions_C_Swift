//
//  Hard.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/3/25.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation
// MARK: - 跳跃游戏2
// 每次确定一次最大的跳跃范围
// 用end来控制跳跃范围，小于end的都属于一次跳跃
// 时间复杂度O(n)
func jump(_ nums: [Int]) -> Int {
    if nums.count < 2 {
        return 0
    }
    var curMax = 0
    var result = 0
    var end = 0
    for (i,n) in nums.enumerated() {
        curMax = max(i+n,curMax)
        if curMax >= nums.count - 1 {
            result += 1
            break
        }
        if i == end {
            end = curMax
            result += 1
        }
    }
    return result
}

// 回溯 写的有点傻
var result = 0
func appendJump(_ nums: [Int], _ curIndex: Int, _ totalStep: Int) {
    let step = nums[curIndex]
    if curIndex + 1 + step >= nums.count {
        result = min(result , totalStep)
        return
    } else if step > 0 && totalStep+1 < result {
        var maxDis = 0
        var maxIndex = 0
        var tempNums = nums
        for i in 1...step {
            let nextIndex = curIndex+i
            if totalStep+1 < result {
                if nums[nextIndex] + nextIndex >= nums.count - 1 {
                    result = min(result , totalStep+1)
                    return
                } else if nums[nextIndex] + nextIndex > maxDis {
                    if nums[nextIndex] + nextIndex > curIndex + step - i {
                        maxDis = nums[nextIndex] + nextIndex
                        maxIndex = nextIndex
                    } else {
                        maxDis = curIndex + step - i
                        tempNums[nextIndex] = curIndex + step - i
                        maxIndex = nextIndex
                    }
                }
            }
        }
        appendJump(tempNums, maxIndex, totalStep+1)
    }
}

func jump1(_ nums: [Int]) -> Int {
    if nums.count <= 1 {
        return 0
    }
    result = nums.count
    appendJump(nums, 0, 1)
    return result
}
