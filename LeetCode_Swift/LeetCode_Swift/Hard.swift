//
//  Hard.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/3/25.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation

// MARK: - N皇后 回溯 ***
var results = [Int](repeating: 0, count: 8)
var strList = [[String]]()

func appendStrList(total: Int) {
    
    var list = [String]()
    for column in results {
        var str = ""
        for j in 0..<total {
            if j == column {
                str += "Q"
            } else {
                str += "."
            }
        }
        list.append(str)
    }
    strList.append(list)
}

func eightQueen( row: Int, total: Int) {
    if row == total {
        appendStrList(total: total)
        return
    }
    for i in 0..<total {
        if isEligible(column: i, row: row) {
            results[row] = i
            eightQueen(row: row+1, total:total)
        }
    }
}

func isEligible(column: Int, row: Int) -> Bool{

    for i in 0..<row {
        if results[i] == column {
            return false
        }
        if row - i == column - results[i] {
            return false
        }
        if row - i == results[i] - column {
            return false
        }
    }
    return true
}

func solveNQueens(_ n: Int) -> [[String]] {
    results = [Int](repeating: 0, count: n)
    eightQueen(row: 0, total: n)
    return strList
}

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
