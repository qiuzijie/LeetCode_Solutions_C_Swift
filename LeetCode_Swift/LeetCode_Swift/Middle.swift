//
//  Middle.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2019/5/7.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

import Foundation

// MARK: - 36
func isValidSudoku(_ board: [[Character]]) -> Bool {
    var rows = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
    var cols = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
    var boxes = [[Bool]](repeating: [Bool](repeating: false, count: 9), count: 9)
    
    for i in 0..<9 {
        for j in 0..<9 {
            let c = board[i][j]
            if var num = Int(String(c))  {
                num -= 1
                let boxIndex = i/3*3 + j/3
                if rows[i][num] || cols[j][num] || boxes[boxIndex][num] {
                    return false
                } else {
                    rows[i][num] = true
                    cols[j][num] = true
                    boxes[boxIndex][num] = true
                }
            }
        }
    }
    return true
}

// MARK: - 55 跳跃游戏
// 动态规划 O(n^2) 空间：O(n)
func canJump1(_ nums: [Int]) -> Bool {
    var dp = [Bool](repeating: false, count: nums.count)
    for (i,_) in nums.enumerated() {
        if i == 0 {
            dp[0] = true
            continue
        }
        for j in (0..<i).reversed() {
            if dp[j] && nums[j] >= i-j {
                dp[i] = true
                break
            }
        }
    }
    print(dp)
    return dp.last!
}

// 贪心算法 O(n) 空间：O(n)
// 记录位于当前位置时能达到的最大步数
func canJump2(_ nums: [Int]) -> Bool {
    var dp = [Int](repeating: -1, count: nums.count)
    for (i,_) in nums.enumerated() {
        if i == 0 {
            dp[0] = nums[0]
            continue
        }
        let j = i-1
        if dp[j] >= 1{
            dp[i] = (dp[j]-1)>nums[i] ? (dp[j]-1) : nums[i]
        }
    }

    return dp.last! > -1
}

// 贪心算法 O(n) 空间：O(1)
// 更新跳到下个位置时的最大步数 若当前位置+最大步数 > 总数 则能达到末尾。
func canJump3(_ nums: [Int]) -> Bool {
    if nums.count < 2 {
        return true
    }
    var curMax = nums[0]
    for i in 0..<nums.count {
        // 大于1就表示位置i可以达到
        if curMax < 1 {
            return false
        }
        curMax = max(curMax-1, nums[i])
        if curMax + i >= nums.count-1 {
            return true
        }
    }

    return false
}

// 记录当前能走到最远的位置 O(n) 最佳实践
func canJump(_ nums: [Int]) -> Bool {

    var maxIndex = 0
    for i in 0..<nums.count {
        if maxIndex < i {
            return false
        }
        maxIndex = max(i+nums[i], maxIndex)
        if maxIndex >= nums.count-1 {
            return true
        }
    }
    return false
}

// MARK: - 62 不同路径
// 动态规划 O(m*n) 空间O(m*n)
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    var dp = [Int: Int]()
    dp[0] = 1
    dp[1] = 1
    dp[m] = 1
    for row in 0..<n {
        for column in 0..<m {
            let index = m*row + column
            if dp[index] == nil {
                            var step = 0
                if row-1 >= 0 {
                    step += dp[m*(row-1) + column]!
                }
                if column - 1 >= 0 {
                    step += dp[m*row + (column-1)]!
                }
                dp[index] = step
            }
        }
    }
    let index = m*(n-1) + m-1
    return dp[index]!
}
// MARK: -  不同路径2
// 加一个简单判断 有障碍就为0
func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    var dp = [Int: Int]()
    if obstacleGrid[0][0] == 1 {
        return 0
    } else {
        dp[0] = 1
    }

    var finalStep = 1
    for row in 0..<obstacleGrid.count {
        let m = obstacleGrid[row].count
        for column in 0..<m {
            let index = m*row + column
            if obstacleGrid[row][column] == 1 {
                dp[index] = 0
                finalStep = 0
            } else if dp[index] == nil {
                var step = 0
                if row-1 >= 0 {
                    step += dp[m*(row-1) + column]!
                }
                if column - 1 >= 0 {
                    step += dp[m*row + (column-1)]!
                }
                dp[index] = step
                finalStep = step
            }
        }
    }
    return finalStep
}

// MARK: - 17 电话号码组合
// 回溯
private let digitDic = ["2":"abc",
           "3":"def","4":"ghi",
           "5":"jkl","6":"mno",
           "7":"pqrs","8":"tuv","9":"wxyz"]

private var leeterList = [String]()

func letterAppend(_ digit: String, _ curStr: String){

    if let d = digit.first {
        for leeter in digitDic[String(d)]! {
            let str = curStr + String(leeter)
            letterAppend(String(digit.dropFirst()), str)
        }
    } else {
        leeterList.append(curStr)
        return
    }
}

func letterCombinations(_ digits: String) -> [String] {
    if digits.count == 0 {
        return [String]()
    }
    letterAppend(digits,"")
    return leeterList
}

// MARK: - 46 全排列
private var results = [[Int]]()

func appendNums(_ nums: [Int], _ curNums: [Int]) {
    if nums.count == 0 {
        results.append(curNums)
    } else {
        for (i,n) in nums.enumerated() {
            var cur = curNums
            cur.append(n)
            var tempNums = nums
            tempNums.remove(at: i)
            appendNums(tempNums, cur)
        }
    }
}

func permute(_ nums: [Int]) -> [[Int]] {
    let curNums = [Int]()
    appendNums(nums, curNums)
    return results
}
