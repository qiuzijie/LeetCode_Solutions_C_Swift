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

// MARK: - 15 三数之和 ***

// O(NlogN)+O(n)∗O(n)，O(n^2)
func threeSum(_ nums: [Int]) -> [[Int]] {
    // 数量小于3退出
    // 排序后首位大于0退出
    if nums.count < 3 {
        return [[Int]]()
    }
    var result = [[Int]]()
    // O(nlogn)
    let sorted = nums.sorted()
    if sorted[0] > 0 {
        return [[Int]]()
    }
    var left = 0
    var right = 0
    
    // O(n^2)
    for i in 0..<sorted.count-2 {
        // 只要最低位大于0，就说明不得行了
        if sorted[i] > 0 {
            return result
        }
        // 避免重复
        if i > 0 && sorted[i] == sorted[i-1] {
            continue
        }
        left = i+1
        right = sorted.count-1
        while left < right {
            let sum = -sorted[i]
            let cur = sorted[left] + sorted[right]
            if cur > sum {
                right -= 1
            } else if cur < sum {
                left += 1
            } else {
                // 找到了
                result.append([sorted[i],sorted[left],sorted[right]])
                // 避免重复
                while sorted[right] == sorted[right-1] && right > left {
                    right -= 1
                }
                while sorted[left] == sorted[left+1] && right > left {
                    left += 1
                }
                right -= 1
                left += 1
            }
        }
    }

    return result
}

// 在超时边缘徘徊
// 时间O(n^2)
// 空间O(n+n)
func threeSum1(_ nums: [Int]) -> [[Int]] {
    if nums.count < 3 {
        return [[Int]]()
    }
    // 三数相加为0 x y z
    var result = [[Int]]()
    var mapX = [Int: Int]()
    
    for i in 0..<nums.count-2 {
        // 去重
        if mapX[nums[i]] != nil {
            continue
        } else {
            mapX[nums[i]] = 1
        }
        let sum = -nums[i]
        var mapYZ = [Int: Int]()
        for j in i+1..<nums.count {
            let y = nums[j]
            let z = sum - y
            // 判断之前x有没有加入过
            if mapX[y] == 2 || mapX[z] == 2 {
                continue
            }
            // 找到了
            if mapYZ[z] == 1 {
                result.append([nums[i],y,z])
                mapYZ[y] = 2
                mapYZ[z] = 2
            }
            // 把自己加入map中
            if mapYZ[y] == nil {
                mapYZ[y] = 1
            }
        }
        mapX[nums[i]] = 2
    }
    return result

// MARK: - 面试题59 队列的最大值 **
// 方2：利用一个双端队列，按递减存放，插入时从尾部pop出比插入元素小的数

/// 利用一个同步的辅助队列 存放当前位置的最大值
class MaxQueue {
    var queue = [Int]()
    var maxQueue = [Int]()
    
    func max_value() -> Int {
        return maxQueue.first ?? -1
    }
    // 每当一个元素进队列时 更新辅助队列
    // 队列中比当前插入元素小的数 将会被影响 更新为最大值
    func push_back(_ value: Int) {
        queue.append(value)
        maxQueue = maxQueue.map { (v) -> Int in
            return max(value, v)
        }
        maxQueue.append(value)
        
    }
    
    func pop_front() -> Int {
        if queue.count > 0 {
            maxQueue.removeFirst()
            return queue.removeFirst()
        }
        return -1
    }
}

// MARK: - 322 零钱兑换 ***
func helper(target: Int, coins: [Int], cache: inout [Int: Int]) -> Int {
    if target == 0 {
        return 0
    } else if target < 0 {
        return -1
    }
    var m = -1
    if let v = cache[target] {
        return v
    }
    
    for c in coins {
        let v = helper(target: target-c, coins: coins, cache: &cache)
        if v >= 0 && m < 0 {
            m = v
        } else if (v >= 0 && m >= 0) {
            m = min(v, m)
        }
    }
    
    let result = m >= 0 ? (m+1) : m
    cache[target] = result
    return result
}

/// 动态规划 自上而下 O(CN)
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var cache = [Int:Int]()
    return helper(target: amount, coins: coins, cache: &cache)
}

/// 动态规划 自下而上 O(CN)
func coinChange2(_ coins: [Int], _ amount: Int) -> Int {
    var result = [Int](repeating: -1, count: amount+1)
    result[0] = 0
    for i in 0...amount {
        for c in coins {
            if i-c >= 0 {
                if result[i-c] >= 0 {
                    if result[i] >= 0 {
                        result[i] = min(result[i], result[i-c]+1)
                    } else {
                        result[i] = result[i-c]+1
                    }
                }
            }
        }
    }
    return result[amount]
}

// 和零钱兑换2一样，每次添加一种硬币类型
func coinChange3(_ coins: [Int], _ amount: Int) -> Int {
    var dp = [Int](repeating: -1, count: amount+1)
    dp[0] = 0
    if amount == 0 {
        return 0
    }
    for c in coins {
        for money in 1...amount {
            if money - c >= 0 && dp[money-c] >= 0 {
                if dp[money] > 0 {
                    dp[money] = min(dp[money], dp[money-c]+1)
                } else {
                    dp[money] = dp[money-c]+1
                }
            }
        }
    }
    return dp[amount]
}

// MARK: - 322 零钱兑换2 *****
// 假设只有一种硬币的时候，每种金额只有1种或0种组合情况
// 动态规划，每次添加一种硬币，然后更新每种金额的组合情况
// amount-coin >= 0 就代表多出了 dp[amount-coin] 种情况
// 每次金额加一块动态规划我没弄出来。
;999/000;;;;;;;000000,
0..`func change(_ amount: Int, _ coins: [Int]) -> Int {
    var dp = [Int](repeating: 0, count: amount+1)
    dp[0] = 1
    if amount == 0 {
        return 1
    }
    for c in coins {
        for money in 1...amount {
            if money - c >= 0 && dp[money-c] > 0 {
                dp[money] += dp[money-c];
            }
        }
    }
    return dp[amount]
}

// MARK: - 300 最长上升子序列 ***
// 动态规划
// 第i个位置结束的最大长度 等于 dp[i]=max(dp[j])+1,其中0≤j<i且num[j]<num[i]
// O(n^2) 空间复杂度：用到一个深度为n的数组，O(n)
func lengthOfLIS(_ nums: [Int]) -> Int {
    var maxLength = 0
    var dp = [Int]()
    for (i,n) in nums.enumerated() {
        var curMax = 1
        for j in 0..<i {
            if n > nums[j] {
                curMax = max(dp[j]+1, curMax)
            }
        }
        dp.append(curMax)
        maxLength = max(maxLength, curMax)
    }
    
    return maxLength
}

// 贪心算法 假设最大上升子序列长度为n，那么我们遍历求出长度为 1...n 的子序列的最小末尾值
// d[i]代表长度为 i+1 的上升子序列的最小结尾元素
// 如果我们要使上升子序列尽可能的长，则我们需要让序列上升得尽可能慢，因此我们希望每次在上升子序列最后加上的那个数尽可能的小。
// 时间复杂O(n*log2^n) 空间复杂O(n)
func lengthOfLIS2(_ nums: [Int]) -> Int {
    var d = [Int]()
    for (i,n) in nums.enumerated() {
        if i == 0 || n > d.last! {
            d.append(n)
        } else {
            // 使用二分法找大于n的最小值位置然后替换
            var left = 0
            var right = d.count-1
            var index = 0
            while left <= right {
                let mid = (left+right)/2
                if d[mid] >= n {
                    right = mid-1
                    index = mid
                } else {
                    left = mid+1
                }
            }
            d[index] = n
            print(d)
        }
    }
    
    return d.count
}

// MARK: - 343 割绳子 整数拆分 **

// 动态规划 自下而上
// f(n) : max(f(n-i)*f(i),(n-i)*i,f(n-i)*i,(n-i)*f(i)) i = 1...n-1
// 将一根绳子切成两份 最大的乘积可能是4种情况：直接相乘、左绳子继续切割、右绳子继续切分、左右都切分
func integerBreak(_ n: Int) -> Int {
    var dp = [Int](repeating: 1, count: n+1)
    dp[0] = 0
    dp[1] = 1

    for i in 2...n {
        for j in 1...i/2 {
            let left = j
            let right = i-j
            let curMax = max(left*right, max(dp[left]*right, max(left*dp[right], dp[right]*dp[left])))
            dp[i] = max(dp[i], curMax)
        }
    }
    
    return dp[n]
}

// 递归 自上而下
func helper(_ n: Int, _ dp: inout [Int]) -> Int {
    if n < 2 {
        return 0
    } else if n == 2 {
        return 1
    }
    
    var curMax = 0
    for i in 1...n/2 {
        let left = i
        let right = n-i
        let lValue = left<dp.count ? dp[left] : helper(left, &dp)
        let rValue = right<dp.count ? dp[right] : helper(right, &dp)
        let m = max(left*right, max(left*rValue, max(lValue*right, lValue*rValue)))
        curMax = max(m, curMax)
    }
    dp.append(curMax)
    return curMax
}

func cuttingRope(_ n: Int) -> Int {
    var dp = [Int]()
    dp.append(0)
    dp.append(1)
    dp.append(1)
    return helper(n, &dp)
}

// MARK: - 365 水壶问题 *****
// 硬写出来的答案，说不清楚逻辑
func canMeasureWater(_ x: Int, _ y: Int, _ z: Int) -> Bool {
    if z == x || z == y || z == 0 || z == x + y {
        return true
    } else if x == 0 || y == 0 {
        return false
    }
    let max = x > y ? x : y
    let min = x > y ? y : x
    var water = min
    var diff = 0
    // 这个退出循环的判断很玄学
    while water != max {
        if water == z || water + min == z {
            return true
        }
        if water > max {
            diff = water - max
            if diff == z || diff + water == z || diff + min == z {
                return true
            }
            water = diff
        } else {
            water += min
        }
    }
    return false
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

// MARK: - 22 括号生成
// 回溯法
var parenthesis = [String]()

func appendList(_ str: String, _ n1: Int, _ n2: Int) {
    if n1 == 0 && n2 == 0 {
        if !parenthesis.contains(str) {
            parenthesis.append(str)
        }
        return
    }
    
    if n1 > 0 {
        let append = str+"("
        appendList(append, n1-1, n2)
    }
    if n2-n1 > 0 {
        let append = str+")"
        appendList(append, n1, n2-1)
    }
}

func generateParenthesis(_ n: Int) -> [String] {
    if n == 0 {
        return [String]()
    }
    appendList("", n, n)
    print(parenthesis)
    return parenthesis
}

// MARK: - 78 子集
// 回溯法
class Solution {
var subsetList = [[Int]]()

func appendSubsets(_ nums: [Int], _ appends: [Int]) {
    subsetList.append(appends)
    if nums.count == 0 {
        return
    }

    for (i,n) in nums.enumerated() {
        var temp = appends
        temp.append(n)
        var list = nums
        list.removeSubrange(0...i)
        appendSubsets(list, temp)
    }
}

func subsets(_ nums: [Int]) -> [[Int]] {
    appendSubsets(nums, [Int]())
    return subsetList
}
}

// MARK: - 820 单词的压缩编码 ** 字典树
 
// 字典树：没写

// 保留所有不是其他单词后缀的字符串
func minimumLengthEncoding(_ words: [String]) -> Int {
    // 首先去重
    var wordsSet = Set(words)
    let temp = wordsSet
    // 所有字符串的后缀遍历一遍，不包括本身
    for str in temp {
        // 一个字母的字符串不判断
        if str.count > 1 {
            for i in 1..<str.count {
                let compare = str[str.index(str.startIndex, offsetBy: i)..<str.endIndex]
                // 去除为他人后缀的字符串
                if wordsSet.contains(String(compare)) {
                    wordsSet.remove(String(compare))
                }
            }
        }
    }
    var count = 0
    wordsSet.forEach { (str) in
        count += str.count
        count += 1
    }
    return count
}


// 逆转、排序、再比较相邻字符串
func minimumLengthEncoding1(_ words: [String]) -> Int {
    if words.count == 0 {
        return 0
    }
    var sorted = words.map { (str) -> String in
        return String(str.reversed())
    }
    sorted.sort()
    print(sorted)
    
    var lastStr = sorted[0]
    var count = lastStr.count
    
    for i in 1..<sorted.count {
        let curStr = sorted[i]
        var flag = true
        for (j,c) in lastStr.enumerated() {
            if curStr.count <= j {// 匹配上了
                break
            } else if curStr[curStr.index(curStr.startIndex, offsetBy: j)] != c {
                flag = false
                break
            }
        }
        // 能匹配上
        if flag {
            // 当前比较的比之前的长
            if curStr.count - lastStr.count > 0 {
                count += (curStr.count - lastStr.count)
                lastStr = curStr
            }
        } else {
            // 匹配不上
            lastStr = curStr
            count += 1
            count += curStr.count
        }
    }
    // 最后要拼个#号
    count += 1
    
    return count
}

// MARK: - 945，使数组唯一的最小增量 ***
// 暴力 超时
// 把每个数存到字典中
func minIncrementForUnique1(_ A: [Int]) -> Int {
    var map = [Int: Int]()
    for num in A {
        if map[num] == nil {
            map[num] = 1
        } else {
            map[num]! += 1
        }
    }

    var result = 0
    for num in A {
        if map[num]! > 1 {
            var temp = num + 1
            while map[temp] != nil {
                temp += 1
            }
            result += temp - num
            map[num]! -= 1
            map[temp] = 1
        }
    }
    return result
}

// 先保存重复出现的数，再找有空位的数，那么增量就等于二者之差，先减后增
// 因为A中大小小于40000，所以最坏可能所有都为39999，那么需要加到79997，才能不重复
func minIncrementForUnique2(_ A: [Int]) -> Int {
    var map = [Int](repeating: 0, count: 80000)
    for num in A {
        map[num] += 1
    }
    var result = 0
    var temp = 0
    for (i,v) in map.enumerated() {
        if v > 1 {// 有重复
            temp += v-1
            result -= i*(v-1)
        } else if v == 0 && temp > 0 {
            temp -= 1
            result += i
        }
    }
    return result
}

/*
 先排序，然后比较相邻数字
 若相同也是记录下来
 当不同的时候判断两个数字之间的空格数，然后算增量
 如果遍历完还存在重复的，那么就从数组最后一个数开始挨个加上。
 */
func minIncrementForUnique(_ A: [Int]) -> Int {
    if A.count < 1 {
        return 0
    }
    let sorted = A.sorted()
    var result = 0
    var temp = 0
    for i in 1..<sorted.count {
        if sorted[i] == sorted[i-1] {
            result -= sorted[i]
            temp += 1
        } else if temp > 0 {
            let differ = sorted[i] - sorted[i-1] - 1
            let count = min(differ, temp)
            if count > 0 {
                for value in 1...count {
                    result += (sorted[i-1]+value)
                    temp -= 1
                }
            }
        }
    }
    // 若还存在重复的，则从数组最后一个数开始取temp个相加
    if temp > 0 {
        let last = sorted.last!
        result += (temp*last + temp*(temp+1)/2)
        // 直观的算法
//        for i in 1...temp {
//            result += (last+i)
//        }
    }
    return result
}

// MARK: - 1162 地图分析 ***** 还没解出来

// 广度遍历，超时
// 找出每个大海和最近的陆地的距离，其中距离最大的就是离陆地最远的海洋
func maxDistance(_ grid: [[Int]]) -> Int {
    var queue = [Int]()
    var maxDis = -1
    let R = grid.count
    let C = grid[0].count
    for row in 0..<R {
        for column in 0..<C {
            // 遍历每一个大海
            if grid[row][column] == 0 {
                let index = C*row + column
                queue.append(index)
                // 记录已经访问过的方格
                var visited = [Int: Int](dictionaryLiteral: (index,1))
                while !queue.isEmpty {
                    let i = queue.removeFirst()
                    let r = i/C
                    let c = i%C
                    for n in 0...3 {
                        var nr = r
                        var nc = c
                        if n == 0 {
                            nr -= 1
                        } else if n == 1 {
                            nr += 1
                        } else if n == 2 {
                            nc -= 1
                        } else {
                            nc += 1
                        }
                        let temp = nr*C + nc
                        if visited[temp] == nil && nr >= 0 && nc >= 0 && nr < R && nc < C {
                            visited[temp] = 1
                            let value = grid[nr][nc]
                            if value == 0 {
                                queue.append((temp))
                            } else { // 遇到陆地了，离这个岛屿最近的陆地
                                let dis = abs(nr-row) + abs(nc-column)
                                maxDis = max(dis, maxDis)
                                queue.removeAll()
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    return maxDis
}
