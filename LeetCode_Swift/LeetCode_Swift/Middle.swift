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
class solution46{
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
}


// MARK: - 15 三数之和 ***

// 排序 再左右指针找
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
}

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
func change(_ amount: Int, _ coins: [Int]) -> Int {
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

// MARK: - 200 岛屿数量 深度遍历

class Solution200 {
    
    func dfs(_ grid: inout [[Character]], _ row: Int, _ column: Int) {
        guard row >= 0 && column >= 0 && row < grid.count && column < grid[row].count && grid[row][column] == "1" else {
            return
        }
        grid[row][column] = "0"
        dfs(&grid, row-1, column)
        dfs(&grid, row+1, column)
        dfs(&grid, row, column-1)
        dfs(&grid, row, column+1)
    }
    
    
    func numIslands(_ grid: [[Character]]) -> Int {
        var ret = 0
        var grid = grid
        
        for row in 0..<grid.count {
            for column in 0..<grid[row].count {
                if grid[row][column] == "1" {
                    ret += 1
                    dfs(&grid, row, column)
                }
            }
        }
        
        return ret
    }
    
    func numIslands1(_ grid: [[Character]]) -> Int {
        var visited = grid
        var ret = 0
        
        let R = grid.count
        for row in 0..<grid.count {
            let C = grid[row].count
            for column in 0..<C {
                if visited[row][column] == "1" {
                    visited[row][column] = "0"
                    ret += 1
                    var queue = [(Int, Int)]()
                    queue.append((row, column))
                    while !queue.isEmpty {
                        let index = queue.removeFirst()
                        for i in 0..<4 {
                            var r = index.0
                            var c = index.1
                            if i == 0 {
                                r += 1
                            } else if i == 1 {
                                r -= 1
                            } else if i == 2 {
                                c -= 1
                            } else {
                                c += 1
                            }
                            if r >= 0 && c >= 0 && r < R && c < C && visited[r][c] != "3" {
                                if visited[r][c] == "1" {
                                    queue.append((r,c))
                                }
                                visited[r][c] = "0"
                            }
                        }
                    }
                }
            }
        }
        
        return ret
    }
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

// MARK: - 912 排序

// MARK: - 堆排序 ✔️
// 比快排要慢一半
// 大顶堆
class SolutionHeap {
    
    func sortArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        buildHeap(&nums)
        
        var k = nums.count-1
        while k > 0 {
            // 堆顶和堆尾交换，数组从末尾逐渐有序
            nums.swapAt(0, k)
            k -= 1
            heapify(&nums, 0, k)
        }
        
        return nums
    }

    func buildHeap(_ nums: inout [Int]) {
        if nums.count <= 1 {
            return
        }
        let finalParNode = (nums.count)/2-1
        // 从最后一个父节点开始调整
        for i in (0...finalParNode).reversed() {
            heapify(&nums, i, nums.count-1)
        }
    }
    // 自上而下调整
    func heapify(_ nums: inout [Int], _ i: Int, _ n: Int) {
        var curNode = i
        while true {
            // (i+1)*2-1 左子节点
            let l = (curNode+1)*2-1
            let r = (curNode+1)*2
            var target = curNode
            if l <= n && nums[l] > nums[curNode] {
                target = l
            }
            if r <= n && nums[r] > nums[target] {
                target = r
            }
            if target == curNode {
                break
            } else {
                nums.swapAt(curNode, target)
                curNode = target
            }
        }
    }
}

// MARK: - 冒泡、选择、插入、希尔 ✔️
class Solution912_normal {
    // 冒泡 超时
    func sortArray1(_ nums: [Int]) -> [Int] {
        var nums = nums
        for i in 0..<nums.count {
            var flag = true
            for j in 0..<nums.count-i-1 {
                if nums[j] > nums[j+1] {
                    let temp = nums[j]
                    nums[j] = nums[j+1]
                    nums[j+1] = temp
                    flag = false
                }
            }
            if flag {
                break
            }
        }
        return nums
    }
    
    // 直接插入 超时
    func sortArray2(_ nums: [Int]) -> [Int] {
        var nums = nums
        for i in 0..<nums.count {
            let value = nums[i]
            var k = i-1
            while k >= 0 {
                if nums[k] > value {
                    nums[k+1] = nums[k]
                } else {
                    break
                }
                k -= 1
            }
            nums[k+1] = value
        }
        return nums
    }
    
    // 选择排序 超时
    func sortArray3(_ nums: [Int]) -> [Int] {
        var nums = nums
        for i in 0..<nums.count {
            var min = nums[i]
            var index = i
            for j in i..<nums.count {
                if nums[j] < min {
                    min = nums[j]
                    index = j
                }
            }
            if index != i {
                let temp = nums[i]
                nums[i] = nums[index]
                nums[index] = temp
            }
        }
        return nums
    }
    
    // 希尔排序 性能甚至比sorted还好，堪比快排
    func sortArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        var dk = nums.count/2
        while dk >= 1 {
            for i in dk..<nums.count {
                let value = nums[i]
                var j = i-dk
                while j >= 0 {
                    if nums[j] > value {
                        nums[j+dk] = nums[j]
                    } else {
                        break
                    }
                    j -= dk
                }
                nums[j+dk] = value
            }
            dk = dk/2
        }
        return nums
    }
}

// MARK: - 归并✔️
class solution912_merge {
    // 归并排序 性能是目前O(nlogn)算法中最差的
    // 递推公式：merge_sort(p…r) = merge(merge_sort(p…q), merge_sort(q+1…r))
    // 终止条件：p >= r 不用再继续分解
    
    func mergeSort(_ nums: inout [Int], _ p: Int, _ q: Int) {
        if p >= q {
            return
        }
        let r = (p+q)/2
        mergeSort(&nums, p, r)
        mergeSort(&nums, r+1, q)
        merge(&nums, p, r, q)
    }
    
    func merge(_ nums: inout [Int], _ p: Int, _ r: Int, _ q: Int ){
        var left = p
        var right = r+1
        var temp = [Int]()
        while left <= r || right <= q {
            if right > q {
                temp.append(nums[left])
                left += 1
            } else if left > r {
                temp.append(nums[right])
                right += 1
            } else if nums[left] <= nums[right] {
                temp.append(nums[left])
                left += 1
            } else {
                temp.append(nums[right])
                right += 1
            }
        }
    
        for i in p...q {
            nums[i] = temp.removeFirst()
        }

    }
    
    func sortArray(_ nums: [Int]) -> [Int] {
        var nums = nums
        mergeSort(&nums, 0, nums.count-1)
        return nums
    }
}
// MARK: - 快排✔️
// 递推公式：quick_sort(p…r) = quick_sort(p…q-1) + quick_sort(q+1… r)终止条件：p >= r
class Solution912_quickSort {
    
    // 原地分区
    func partition(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
          /// 填坑法
        //    var index = left
        //    let number = nums[left]
        //    var l = left
        //    var r = right
        //    while l < r {
        //        // 每次判断一下移动哪边的指针
        //        // 从右到左判断
        //        if index == l {
        //            if nums[r] < number {
        //                nums[index] = nums[r]
        //                index = r
        //                l += 1
        //            } else {
        //                r -= 1
        //            }
        //        } else if index == r {// 从左到右判断
        //            if nums[l] > number {
        //                nums[index] = nums[l]
        //                index = l
        //                r -= 1
        //            } else {
        //                l += 1
        //            }
        //        }
        //    }
        //    nums[index] = number
        //    return index
            
        /// 双指针法
        /// 把l作为基准点的最终位置，找到它！同时保证l左边的数都小于基准数
//        let number = nums[left]
//        var l = left
//        var r = right
//        while l != r {
//            // 要先从右边开始找
//            // 从右到左找出小于基位数的
//            while nums[r] > number && l < r {
//                r -= 1
//            }
//            // 从左到右找出大于基位数的
//            while nums[l] <= number && l < r {
//                l += 1
//            }
//            if l < r {
//                let temp = nums[l]
//                nums[l] = nums[r]
//                nums[r] = temp
//            }
//        }
//        nums[left] = nums[l]
//        nums[l] = number
//        return l
        
        // 把最后一位当做对比数
        let pivot = nums[right]
        // 以 i 为中心分为两个部分, left...i为已处理部分且小于pivot部分
        var i = left
        var j = left
        
        while j < right {
            if nums[j] <= pivot {
                if nums[i] > pivot {
                    let temp = nums[i]
                    nums[i] = nums[j]
                    nums[j] = temp
                }
                i += 1
            }
            j += 1
        }
        if i != j {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }

        return i
    }
    
    func quickHelper(_ left: Int, _ right: Int, _ nums: inout [Int]){
        if left >= right {
            return
        }

        let pivot = partition(&nums, left, right)
        quickHelper(left, pivot-1, &nums)
        quickHelper(pivot+1, right, &nums)
    }

    
    func sortArray(_ nums: [Int]) -> [Int] {
        var list = nums
        quickHelper(0, list.count-1, &list)
        return list
    }
}
// MARK: - 92 在一个区域内反转链表2 **
func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
    // 增加 dummy ，处理从头结点开始逆转和其他情况
    let dummy = ListNode(0)
    dummy.next = head
    var pre = dummy
    
    // 找到需要逆转的前一个节点
    for _ in 1..<m {
        pre = pre.next!
    }

    // 需要反转的第一个节点，保持不变，每次指向下个需要反转的结点
    // 相当于从 pre 开始到 cur 之间尾插法插入反转的结点
    let cur = pre.next
    for _ in m..<n {
        let temp = cur?.next
        cur?.next = temp?.next
        temp?.next = pre.next
        pre.next = temp
    }
    
    return dummy.next
}

// MARK: - 19 删除链表倒数第N个节点

// 快指针先移动n+1个位置，然后快慢指针同时移动，保持n的距离。
// 那么快指针为空的时候，慢指针刚好指向倒数第n个节点的前一个节点。
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    var fast: ListNode? = dummy
    var slow = dummy
    for _ in 0...n {
        fast = fast?.next
    }
    while fast != nil {
        fast = fast?.next
        slow = slow.next!
    }
    slow.next = slow.next?.next
    return dummy.next
}

// MARK: - 2 两数相加 链表为逆序

// 转换为数字相加，再按位构造链表，超过Int最大位数就gg

// 模拟相加
// 时间：O(max(m,n)) 空间：最坏为max(m,n)+1， O(max(m,n))
func addTwoNumbers1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    
    
    let dummy = ListNode(0)
    var tailNode = dummy
    // 判断是否进位
    var flag = false
    var curNum = 0
    var node1 = l1
    var node2 = l2
    while node1 != nil || node2 != nil {
        if node1 == nil {
            curNum = node2!.val
            node2 = node2?.next
        } else if node2 == nil {
            curNum = node1!.val
            node1 = node1?.next
        } else {
            // 相加
            let x = node2!.val
            let y = node1!.val
            curNum = x + y
            node2 = node2?.next
            node1 = node1?.next
        }
        // 判断进位
        if flag {
            curNum += 1
        }
        if curNum > 9 {
            curNum = curNum%10
            flag = true
        } else {
            flag = false
        }
        let node = ListNode(curNum)
        tailNode.next = node
        tailNode = node
    }
    // 判断最后有木有进位
    if flag {
        let node = ListNode(1)
        tailNode.next = node
    }
    return dummy.next
}

// MARK: - 445 两数相加2

// 模拟相加，利用栈，每位相加，顺带着头插法构造链表
// 时间：每次时间都为max(m,n)+m+n, O(max(m,n)) 空间：最坏为max(m,n)+1， O(max(m,n))
func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var q1 = [Int]()
    var q2 = [Int]()
    var temp = l1
    while temp != nil {
        q1.append(temp!.val)
        temp = temp?.next
    }
    temp = l2
    while temp != nil {
        q2.append(temp!.val)
        temp = temp?.next
    }
    
    let dummy = ListNode(0)
    
    // 判断是否进位
    var flag = false
    var curNum = 0
    while q1.count != 0 || q2.count != 0 {
        if q1.count == 0 {
            curNum = q2.removeLast()
        } else if q2.count == 0 {
            curNum = q1.removeLast()
        } else {
            // 相加
            let x = q2.removeLast()
            let y = q1.removeLast()
            curNum = x + y
        }
        // 判断进位
        if flag {
            curNum += 1
        }
        if curNum > 9 {
            curNum = curNum%10
            flag = true
        } else {
            flag = false
        }
        let node = ListNode(curNum)
        node.next = dummy.next
        dummy.next = node
    }
    // 判断最后有木有进位
    if flag {
        let node = ListNode(1)
        node.next = dummy.next
        dummy.next = node
    }
    return dummy.next
}

// MARK: - 328 奇偶链表

// 利用奇偶指针一次遍历构造两个链表再拼接
// 时间:O(n) 空间：几个指针
func oddEvenList(_ head: ListNode?) -> ListNode? {
    let oddHead = head
    var odd = head
    let evenHead = head?.next
    var even = evenHead
    
    while even?.next != nil {
        odd?.next = even?.next
        odd = odd?.next
        
        even?.next = odd?.next
        even = even?.next
    }
    
    odd?.next = evenHead
    
    return oddHead
}

// MARK: - 160 相交链表
// 要保持链表结构，同时空间O(1) 时间O(n)
// 方一：将2个链表逆序或者加入栈，从尾部开始比较公共部分，但不满足条件
// 方二：哈希表法，空间O(n)
// 方三：双指针法 利用总路程相等来做
func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
//    var pA = headA
//    var pB = headB
//    var tail: ListNode?
//
//    while pA != nil && pB != nil {
//        if pA === pB {
//            return pA
//        }
//        if pA?.next == nil {
//            if tail != nil && pA !== tail {
//                return nil
//            } else {
//                tail = pA
//                pA = headB
//            }
//        } else {
//            pA = pA?.next
//        }
//        if pB?.next == nil {
//            if tail != nil && pB !== tail {
//                return nil
//            } else {
//                tail = pB
//                pB = headA
//            }
//        } else {
//            pB = pB?.next
//        }
//
//    }
    
    // 代码优化
    var p0 : ListNode? = headA
    var p1 : ListNode? = headB
    
    // 当不存在相交点时，p0和p1会同时跑到对方的尾结点，此时大家都为nil，退出循环
    while p0 !== p1 {
        p0 = p0 == nil ? headB : p0?.next
        p1 = p1 == nil ? headA : p1?.next
    }
    return p0
}

// MARK: - 94 二叉树的中序遍历

// 递归深度：平均O(log2^n) 最坏O(n)
// 时间：O(n)
var inorderRet = [Int]()
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    if root == nil {
        return inorderRet
    }
    _ = inorderTraversal(root?.left)
    inorderRet.append(root!.val)
    _ = inorderTraversal(root?.right)
    return inorderRet
}

// 利用栈
// 空间：平均O(log2^n) 最坏O(n)，时间O(n)
func inorderTraversal1(_ root: TreeNode?) -> [Int] {
    var stack = [TreeNode]()
    var ret = [Int]()
    var cur = root
    while cur != nil || !stack.isEmpty {
        while cur != nil {
            stack.append(cur!)
            cur = cur?.left
        }
        cur = stack.removeLast()
        ret.append(cur!.val)
        cur = cur?.right
    }
    
    return ret
}

// 颜色标记法，直观
func inorderTraversal2(_ root: TreeNode?) -> [Int] {
    if root == nil {
        return [Int]()
    }
    var stack = [(TreeNode, Int)]()
    var ret = [Int]()
    stack.append((root!,0))
    while !stack.isEmpty {
        let cur = stack.removeLast()
        if cur.1 == 0 {
            if cur.0.right != nil {
                stack.append((cur.0.right!,0))
            }
            stack.append((cur.0,1))
            if cur.0.left != nil {
                stack.append((cur.0.left!,0))
            }
        } else {
            ret.append(cur.0.val)
        }
    }
    
    return ret
}

// 莫里斯遍历 待补充 时间：O(n) 空间：O(1)


// MARK: - 103. 二叉树的锯齿形层次遍历

class Solution103 {
    // 常规层次遍历，特定层级反转 时间：O(n)，空间：O(n+n)，需要一个辅助数组来存放当前层数据
    // 层次遍历也可以在每一层加入一个空节点来判断分层，此时就需要判断节点不为nil再加入了。
    func zigzagLevelOrder1(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        var flag = false
        var queue = [TreeNode?]()
        
        if root != nil {
            queue.append(root)
            queue.append(nil)
            var curNums = [Int]()
            while !queue.isEmpty {
                let node = queue.removeFirst()
                if node != nil {
                    if flag {
                        // 头部插入 时间：O(k) ，也可以用双端队列时间为：O(1)
                        curNums.insert(node!.val, at: 0)
                    } else {
                        curNums.append(node!.val)
                    }
                    if node?.left != nil {
                        queue.append(node?.left)
                    }
                    if node?.right != nil {
                        queue.append(node?.right)
                    }
                } else {
                    // 上一层级遍历完了
                    flag = !flag
                    ret.append(curNums)
                    curNums.removeAll()
                    if !queue.isEmpty {
                        queue.append(nil)
                    }
                }
            }
        }
        return ret
    }
    
    var result = [[Int]]()
    func helper(_ root: TreeNode?, _ curLev: Int) {
        if root == nil {
            return
        }
        if curLev > result.count {
            var nums = [Int]()
            nums.append(root!.val)
            result.append(nums)
        } else {
            var nums = result[curLev-1]
            if curLev % 2 != 0 {
                nums.append(root!.val)
            } else {
                nums.insert(root!.val, at: 0)
            }
            result[curLev-1] = nums
        }
        if root?.left != nil {
            helper(root?.left, curLev+1)
        }
        if root?.right != nil {
            helper(root?.right, curLev+1)
        }
    }
    
    // 深度遍历，不需要辅助数组或者双端队列，优秀一点
    // 时间：O(n)，空间：递归深度 O(树高(大部分log2^n))，result：O(n)
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        helper(root, 1)
        return result
    }
}

// MARK: - 105 中序+前序构造二叉树
// 如何构造一个树,中序加前序递归构造
// 前序的数组构成：[根节点，左子树节点，右子树节点]
// 递归先构造左子树，前序数组第一个元素为根节点，然后中序数组以这个元素分成该节点的左右子树两部分
// 然后再求该根节点的左右子树
class Solution105 {
    func helper(_ preorder: inout [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 || inorder.count == 0 {
            return nil
        }
        let root = TreeNode(preorder[0])
        var subLeft = [Int]()
        var subRight = [Int]()
        var flag = true
        for num in inorder {
            if num == root.val {
                flag = false
            } else {
                if flag {
                    subLeft.append(num)
                } else {
                    subRight.append(num)
                }
            }
        }
        preorder.removeFirst()
        root.left = helper(&preorder, subLeft)
        root.right = helper(&preorder, subRight)
        return root
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var temp = preorder
        return helper(&temp, inorder)
    }
}

// 记录索引，避免破坏传入的数据结构，避免每次还构造左右子树数组
// 同时构造中序数组元素的位置索引，避免像上面一样每次还循环找分隔点。
class Solution105_1 {
    var curIndex = 0
    var inorderMap = [Int: Int]()
    
    func buildTree(_ preorder: [Int], _ inorder: [Int], _ toIndex: Int, _ fromIndex: Int) -> TreeNode?{
        guard fromIndex >= 0 && toIndex < inorder.count && fromIndex <= toIndex else {
            return nil
        }
        let root = TreeNode(preorder[curIndex])
        let separated = inorderMap[preorder[curIndex]]!
        curIndex += 1
        root.left = buildTree(preorder, inorder, separated-1, fromIndex)
        root.right = buildTree(preorder, inorder, toIndex, separated+1)
        return root;
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        for i in 0..<inorder.count {
            inorderMap[inorder[i]] = i
        }
        return buildTree(preorder, inorder, inorder.count-1, 0)
    }
}

// MARK: - 116 117 填充每个节点的下一个右侧节点指针 1 II

class Solution117 {
    // 层次遍历构造右兄弟
    func connect1(_ root: Node?) -> Node? {
        var queue = [Node?]()
        if root != nil {
            queue.append(root!)
            queue.append(nil)
        }
        var lastNode: Node?
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if node != nil {
                if lastNode != nil {
                    lastNode?.next = node
                }
                lastNode = node
                if node!.left != nil {
                    queue.append(node!.left)
                }
                if node!.right != nil {
                    queue.append(node!.right)
                }
            } else {
                // 上一层级已全部出队，当前层节点全部已入队
                lastNode = nil
                if !queue.isEmpty {
                    queue.append(nil)
                }
            }
        }
        
        return root
    }

    // 指针法 构造每一层的链式关系
    var leftMost: Node?
    func configPrev(_ prev: inout Node?, _ curNode: Node?) {
        if prev == nil {
            prev = curNode
            leftMost = prev
        } else if curNode != nil{
            prev?.next = curNode
            prev = curNode
        }
    }

    func connect(_ root: Node?) -> Node? {
        leftMost = root
        
        while leftMost != nil {
            var cur = leftMost
            var prev: Node?
            // 把当前层级的 node 通过 next 遍历一遍，同时指定好下一层级的 next 关系,类似链表
            while cur != nil {
                configPrev(&prev, cur?.left)
                configPrev(&prev, cur?.right)
                cur = cur?.next
            }
        }
        
        return root
    }
}

// MARK: - 347 前k个高频元素

class Solution347_heap {
    // 利用堆，每次插入的时间复杂度为：O(logk)，总时间复杂度为：O(nlogk)
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var map = [Int: Int]()
        for n in nums {
            map[n, default:0] += 1
        }
        var heap = [Int]()
        for (key,_) in map {
            insert(&heap, map, key, k)
        }
        return heap
    }
    
    func insert(_ nums: inout [Int], _ map: [Int: Int], _ key: Int, _ size: Int) {
        if nums.count == size {
            // 插入的元素大于小顶堆中最小的元素
            if map[nums.first!]! < map[key]! {
                nums[0] = key
                var curIdx = 0
                while true {
                    let lc = (curIdx+1)*2-1 // 左孩子
                    let lr = (curIdx+1)*2 // 右孩子
                    var target = curIdx
                    if lc <= nums.count-1 && map[nums[lc]]! < map[nums[target]]! {
                        target = lc
                    }
                    if lr <= nums.count-1 && map[nums[lr]]! < map[nums[target]]! {
                        target = lr
                    }
                    if target == curIdx {
                        break
                    } else {
                        nums.swapAt(target, curIdx)
                        curIdx = target
                    }
                }
            }
        } else {
            nums.append(key)
            var curIdx = nums.count-1
            var parIdx = (curIdx-1)/2
            while parIdx >= 0 && map[nums[parIdx]]! > map[nums[curIdx]]! {
                nums.swapAt(parIdx, curIdx)
                curIdx = parIdx
                parIdx = (curIdx-1)/2
            }
        }
    }
}


class Solution347 {

    // O(n)，O(n)
    // 桶排序
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        // map记录出现次数
        var map = [Int: Int]()
        for num in nums {
            map[num, default:0] += 1
        }
        
        // 最高的出现频率等于数组大小
        
        var dp = [[Int]](repeating: [], count: nums.count+1)
        
        for (key, count) in map {
            dp[count].append(key)
        }
        
        var ret = [Int]()
        var index = dp.count-1
        while index >= 1 && ret.count < k {
            if dp[index].count > 0 {
                ret.append(contentsOf: dp[index])
            }
            index -= 1
        }
        return ret
    }
    
    func topKFrequent1(_ nums: [Int], _ k: Int) -> [Int] {
        // map记录出现次数
        var map = [Int: Int]()
        for num in nums {
            map[num, default:0] += 1
        }
        
        // 然后再排序构造前k个高频数组
        var sorted = [Int]()
        for (key,value) in map {
            var j = 0
            while j < k {
                if sorted.count > j {
                    let num = sorted[j]
                    if map[num]! < value {
                        // 将位于j以及之后的都往后移动一位
                        // 如果数组数量不够，需要拼接
                        if sorted.count < k {
                            sorted.append(sorted.last!)
                        }
                        for i in (j+1..<sorted.count).reversed() {
                            sorted[i] = sorted[i-1]
                        }
                        sorted[j] = key
                        break;
                    }
                    j += 1
                } else {
                    sorted.append(key)
                    break
                }
            }
        }
        return sorted
    }
}

// MARK: - 75 颜色分类

// 桶排序
class Solution75_1 {
    func sortColors(_ nums: inout [Int]) {
        var colors = [Int](repeating: 0, count: 3)
        for num in nums {
            colors[num] += 1
        }
        nums.removeAll()
        for (i,count) in colors.enumerated() {
            for _ in 0..<count {
                nums.append(i)
            }
        }
    }
}

// 不用额外空间，一趟遍历
class Solution75 {
    // 0 1 2
    func exchange(_ nums: inout [Int], _ i: Int, _ j: Int){
        let temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }
    
    func sortColors(_ nums: inout [Int]) {
        var left = 0
        var right = nums.count-1
        var cur = 0
        // left 记录0分区的末尾位置
        // right 记录2分区的末尾位置
        // 合理交换和不遗漏元素的关键在于
        // cur始终大于等于left，并且有时cur不用向前移动
        while cur <= right {
            if nums[cur] == 0 {
                if cur != left {
                    exchange(&nums, cur, left)
                }
                cur += 1
                left += 1
            } else if nums[cur] == 2 {
                if nums[right] != 2 {
                    exchange(&nums, cur, right)
                }
                right -= 1
            } else {
                cur += 1
            }
        }
    }
}


// MARK:- 215 数组中的第K个最大元素

class Solution215_heap {
    // 构造大小为k的小顶堆，第一个元素就是第k大
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var heap = [Int]()
        for n in nums {
            insert(&heap, n, k)
        }
        return heap.first!
    }
    
    func insert(_ nums: inout [Int], _ num: Int, _ size: Int) {
        if nums.count == size {
            // 插入的元素大于小顶堆中最小的元素
            if nums.first! < num {
                nums[0] = num
                var curIdx = 0
                while true {
                    let lc = (curIdx+1)*2-1 // 左孩子
                    let lr = (curIdx+1)*2 // 右孩子
                    var target = curIdx
                    if lc <= nums.count-1 && nums[lc] < nums[target] {
                        target = lc
                    }
                    if lr <= nums.count-1 && nums[lr] < nums[target] {
                        target = lr
                    }
                    if target == curIdx {
                        break
                    } else {
                        nums.swapAt(target, curIdx)
                        curIdx = target
                    }
                }
            }
        } else {
            nums.append(num)
            var curIdx = nums.count-1
            var parIdx = (curIdx-1)/2
            while parIdx >= 0 && nums[parIdx] > nums[curIdx] {
                nums.swapAt(parIdx, curIdx)
                curIdx = parIdx
                parIdx = (curIdx-1)/2
            }
        }
    }
}

class Solution215 {
    
    func pivot(_ nums: inout [Int], _ l: Int, _ r: Int) -> Int {
        let value = nums[r]
        var i = l
        var j = l
        while j < r {
            if nums[j] >= value {
                if i != j {
                    let temp = nums[i]
                    nums[i] = nums[j]
                    nums[j] = temp
                }
                i += 1
            }
            j += 1
        }
        if i != j {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
        return i
    }
    
    func findPivot(_ nums: inout [Int], _ l: Int, _ r: Int, _ k: Int) -> Int {
        if l > r {
            return -1
        }
        let p = pivot(&nums, l, r)
        
        if p+1 == k {
            return p
        } else if p+1 < k {
            return findPivot(&nums, p+1, r, k)
        } else {
            return findPivot(&nums, l, p-1, k)
        }
    }
    
    // 利用快排的分割区间
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        let p = findPivot(&nums, 0, nums.count-1, k)
        if p >= 0 && p < nums.count {
            return nums[p]
        }
        return -1
    }
}

// MARK: - 162 寻找峰值
// 时间要：O(log^n)
// 前提是：只需要到一个峰值，nums[i] ≠ nums[i+1]，nums[-1] = nums[n] = -∞
class Solution_162 {
    
    // 二分查找
    // 原理：只要数组中存在一个元素比相邻元素大，那么沿着它一定可以找到一个峰值
    // 若mid 大于 mid+1 说明在 l...mid 里面有峰值
    // 若mid 小于 mid+1 说明在 mid+1...r 里面有峰值
    func findPeakElement(_ nums: [Int]) -> Int {
        var l = 0
        var r = nums.count-1
        
        while l < r {
            let mid = (l+r)/2
            if nums[mid] > nums[mid + 1] {
//                if mid-1 >= 0 && nums[mid-1] > nums[mid] {
//                    r = mid-1
//                } else {
//                    return mid
//                }
                r = mid
            } else {
                l = mid + 1
            }
        }
        return l
    }
    
    // 线性查找
    func findPeakElement1(_ nums: [Int]) -> Int {
        for (i,n) in nums.enumerated() {
            if i+1 < nums.count {
                // 只要当前位置大于下一个位置则一定是峰顶，前提是附近没有重复数字
                if n > nums[i+1] {
                    return i
                }
            } else {
                return i
            }
        }
        return 0
    }
}

// MARK: - 34. 在排序数组中查找元素的第一个和最后一个位置
// 复杂度必须是 O(log n) 级别。
// 就是分别两次2分查找最左和最右的元素位置，判断边界有点烦
// 王争说：很多人都觉得变形的二分查找很难写，主要原因是太追求第一种那样完美、简洁的写法。
// 而对于我们做工程开发的人来说，代码易读懂、没 Bug，其实更重要，
class Solution34 {
    func search(_ nums: [Int], _ target: Int, _ l: Int, _ r: Int, _ flag: Bool) -> Int {
        var l = l
        var r = r
        
        while l < r {
            var mid = (l+r)/2
            if !flag {
                mid = (l+r+1)/2
            }
            let value = nums[mid]
            if value > target {
                r = mid-1
            } else if value < target {
                l = mid+1
            } else {
                if flag {
                    r = mid
                } else {
                    l = mid
                }
            }
        }
        return l
    }
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return [-1,-1]
        }
        let left = search(nums, target, 0, nums.count-1, true)
        if nums[left] != target {
            return [-1,-1]
        }
        let right = search(nums, target, left, nums.count-1, false)
        if nums[right] != target {
            return [-1,-1]
        }
        return [left,right]
    }
}

// MARK: - 33 搜索旋转排序数组
// 时间复杂度要：O(log^n)
/*
 以数组中间点为分区，会将数组分成一个有序数组和一个循环有序数组;
 如果首元素小于 mid，说明前半部分是有序的，后半部分是循环有序数组;
 如果首元素大于 mid，说明后半部分是有序的，前半部分是循环有序的数组;
*/

class Solution33 {
    func findMinest(_ nums: [Int]) -> Int {
        var l = 0
        var r = nums.count-1
        
        // 先二分找最小元素位置
        while l < r {
            let mid = (l+r)/2
            let value = nums[mid]
            if value >= nums[l] {// 左半区有序
                if nums[l] < nums[r] {
                    // 找到了
                    break
                } else {// 说明在右半区
                    l = mid+1
                }
            } else {// 右半区升序，说明最小点在左半区
                r = mid
            }
        }
        
        return l
    }
    
    func search(_ nums: [Int], _ l: Int, _ r: Int, _ t: Int) -> Int {
        if l > r {
            return -1
        }
        var l = l
        var r = r
        while l <= r {
            let mid = (l+r)/2
            if nums[mid] == t {
                return mid
            } else if nums[mid] > t {
                r = mid-1
            } else {
                l = mid+1
            }
        }
        return -1
    }
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        let pivot = findMinest(nums)

        /*
         数组被 pivot 分为了两个分区，
         判断target在哪个分区,
         然后从在那个分区立面按常规二分找
         */
        if pivot == 0 {
            return search(nums, 0, nums.count-1, target)
        } else if target >= nums[0] {// 说明在左分区
            return search(nums, 0, pivot, target)
        } else {
            return search(nums, pivot, nums.count-1, target)
        }
    }
}

// MARK: - 240 搜索二维矩阵2
/*
 每行的元素从左到右升序排列。
 每列的元素从上到下升序排列。
 */
class Solution240 {
    
    // 找到小于等于 target 且离的最近的元素
    func findLatest(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count-1
        var ret = -1
        while l <= r {
            if nums[l] > target {
                break
            }
            let mid = (l+r)/2
            let n = nums[mid]
            if n == target {
                return mid
            } else if n > target {
                r = mid-1
            } else {
                l = mid+1
                ret = mid
            }
        }
        return ret
    }
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count < 1 {
            return false
        }
        //先找所属列(最大的小于 target 的列的首元素)
        let firstRows = matrix[0]
        let latestColumn = findLatest(firstRows, target)
        if latestColumn == -1 {
            return false
        } else {
            // ret 可能存在于所有小于等于 latestRow 的列中
            // 右下角是最大的，可以排除左上部分
            var curRow = 0
            for c in (0...latestColumn).reversed() {
                var columns = [Int]()
                for row in curRow..<matrix.count {
                    columns.append(matrix[row][c])
                }
                let latestRow = findLatest(columns, target) + curRow
                curRow = latestRow
                if matrix[latestRow][c] == target {
                    return true
                }
            }
        }
        return false
    }
}

// MARK: - 73 矩阵置零
/*
 给定一个 m x n 的矩阵，如果一个元素为 0，则将其所在行和列的所有元素都设为0。
 请使用原地算法。
 */
class Solution73 {
    
    // 使用额外空间来记录某列某行元素是否需要置为0
    func setZeroes(_ matrix: inout [[Int]]) {
        var rowNeed = [Int](repeating:1 , count: matrix.count)
        var columnNeed = [Int](repeating: 1, count: matrix[0].count)
        
        for r in 0..<matrix.count {
            for c in 0..<matrix[r].count {
                if matrix[r][c] == 0 {
                    rowNeed[r] = 0
                    columnNeed[c] = 0
                }
            }
        }
        
        for r in 0..<matrix.count {
            for c in 0..<matrix[r].count {
                if rowNeed[r] == 0 || columnNeed[c] == 0 {
                    matrix[r][c] = 0
                }
            }
        }
    }
        
    
    // 使用第一列和第一行首位元素来判断此行此列的元素是否需要置为0
    func setZeroes1(_ matrix: inout [[Int]]) {
        
        if matrix.count < 1 {
            return
        }
        
        var colNeed = false
        
        for row in 0..<matrix.count {
            if matrix[row][0] == 0 {
                colNeed = true
            }
            // 跳过第一列
            for column in 1..<matrix[row].count {
                if matrix[row][column] == 0 {
                    // 将所在列第一个元素置为0
                    matrix[0][column] = 0
                    // 将所在行第一个元素置为0
                    matrix[row][0] = 0
                }
            }
        }
        
        // 判断除了第一行第一列的元素，置为0
        for row in 1..<matrix.count {
            for column in 1..<matrix[row].count {
                if matrix[0][column] == 0 || matrix[row][0] == 0 {
                    matrix[row][column] = 0
                }
            }
        }
        
        // 判断第一行需不需要置为0
        if matrix[0][0] == 0 {
            for column in 1..<matrix[0].count {
                matrix[0][column] = 0
            }
        }
        
        // 判断第一列需不需要置为0
        if colNeed {
            for row in 0..<matrix.count {
                matrix[row][0] = 0
            }
        }
    }
}


// MARK: - 49 字母异位词分组
class Solution49 {
    // 原理都是构造哈希表，将同一键值的字符串加入同一数组
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        
        // 比较方法1：两个字符串是异位词：长度相等,排序后相同
        /*
         var map = [String: [String]]()
         for str in strs {
             let key = String(str.sorted())
             if var list = map[key] {
                 list.append(str)
                 map[key] = list
             } else {
                 map[key] = [str]
             }
         }
         */
        
        // 比较方法2：将字符串散列化,
        // key是数量为26的数组，下标代表a-z，值为每个字母出现的次数。
        var map = [[Int]: [String]]()
        
        for str in strs {
            var key = [Int](repeating: 0, count: 26)
            for c in str {
                // k = 0..<26
                let index = (c.asciiValue! - Character("a").asciiValue!)%26
                key[Int(index)] += 1
            }
            if var list = map[key] {
                list.append(str)
                map[key] = list
            } else {
                map[key] = [str]
            }
        }
        
        
        return Array(map.values)
    }
}

// MARK: - 3. 无重复字符的最长子串
class Solution3 {
    /*
     一次遍历
     时间：O(n)
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        /*
         // curStr.firstIndex 导致 O(n^2)，同时还要删除
         var ans = 0
         var curStr = ""
         for c in s {
             if let index = curStr.firstIndex(of: c) {
                 ans = max(ans, curStr.count)
                 curStr.removeSubrange(curStr.startIndex...index)
             }
             curStr += String(c)
         }
         */
        
        /*
         优化1
         时间：O(2n)
         set.contains 是O(1)，哈希表实现的
         所以 Set 是无序的，不能用 set.removeFirst()
         用字符串滑块（l...r）来控制增删
         但是居然还超时了！！！应该是每次只删一个字符，造成了很多个位置被访问了两次
         
        var ans = 0
        var set = Set<Character>()
        var r = 0
        var l = 0
        while r < s.count {
            let c = s[s.index(s.startIndex, offsetBy: r)]
            if set.contains(c) {
                let d = s[s.index(s.startIndex, offsetBy: l)]
                l += 1
                set.remove(d)
            } else {
                set.insert(c)
                r += 1
                ans = max(ans, r-l)
            }
        }
        return ans
         */
        
        /*
         优化2：要将方一一次删的多和方二找得快结合
         时间：O(n)!!
         */
        var ans = 0
        // 记录每个元素最后出现的位置
        var map = [Character: Int]()
        var l = 0
        
        for (r,c) in s.enumerated() {
            if let index = map[c] {
                // 遇到重复的直接将l往前提
                l = max(l, index + 1)
            }
            map[c] = r
            ans = max(ans, r-l+1)
        }
        
        return ans
    }
}

// MARK: - 334. 递增的三元子序列
class Solution334 {
    // 要求算法的时间复杂度为 O(n)，空间复杂度为 O(1)
    // 这个方法应该是在求最大上升子序列中用到的，替换排序中的最小元素
    // 手动模拟几种情况 (8 9 1 2 3) (8 9 1 2 10)
    func increasingTriplet(_ nums: [Int]) -> Bool {
        if nums.count < 3 {
            return false
        }
        var curL = nums[0]
        var curR = nums[0]
        var ret = 1
        for i in 1..<nums.count {
            let n = nums[i]
            if n > curR {
                ret += 1
                curR = n
                if ret == 3 {
                    return true
                }
            } else {
                if n <= curL {
                    if curR == curL {
                        curR = n
                    }
                    curL = n
                } else if n <= curR {
                    curR = n
                }
            }
        }
        return false
    }
}

// MARK: - 621. 任务调度器

// 要最快执行完，就要让 CPU 空闲时间最短，优先执行任务数量最多的
class Solution621 {
    
    func leastInterval1(_ tasks: [Character], _ n: Int) -> Int {
        if n == 0 {
            return tasks.count
        }
        // 先分类
        var map = [Int](repeating: 0, count: 26)
        for t in tasks {
            let key = t.asciiValue! - Character("A").asciiValue!
            map[Int(key)] += 1
        }
        
        map = map.sorted { (v1, v2) -> Bool in
            return v1 > v2
        }
        
        var ret = 0
        while map[0] > 0 {
            // n+1 区间内不能有重复元素
            for i in 0...n {
                if i < map.count {
                    map[i] -= 1
                }
                ret += 1
                if map[0] == 0 {
                    break
                }
            }
            // 每次排序，保证优先执行剩余数量多的任务
            map = map.sorted(by: { (v1, v2) -> Bool in
                return v1 > v2
            })
        }
        
        return ret
    }
    
    /*
     任务的最短执行时间为 minT = (maxTask-1)*(n+1)+1，
     同时会产生 minT-maxTask 个空闲时间，
     我们用其他的任务将这些空闲时间填满，注意如果有多个数量都为最大数量的任务时，最后一行会加入这些元素。
     如果空闲时间都填满了还不够，那么任务执行时间就等于任务数量，因为这样代表着可以没有任何空闲时间执行完任务。
     */
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        if n == 0 {
            return tasks.count
        }
 
        var map = [Int](repeating: 0, count: 26)
        for t in tasks {
            let key = t.asciiValue! - Character("A").asciiValue!
            map[Int(key)] += 1
        }
        map = map.sorted()
        
        let maxTaskCount = map[25]
        var maxTaskTime = (maxTaskCount-1)*(n+1)
        
        for num in map.reversed() {
            if num == 0 {
                break
            }
            if num == maxTaskCount {
                maxTaskTime += 1
            }
        }
        
        return max(maxTaskTime, tasks.count)
    }
}


// MARK: - 1439. 有序矩阵中的第 k 个最小数组和
// 暴力
class Solution {
    func kthSmallest(_ mat: [[Int]], _ k: Int) -> Int {
        var lastMinRows = [Int]()
        
        for r in 0..<mat.count {
            var curRows = [Int]()
            for c in 0..<mat[r].count {
                if c >= k {
                    break
                }
                if lastMinRows.count > 0 {
                    for num in lastMinRows {
                        curRows.append(num+mat[r][c])
                    }
                } else {
                    curRows.append(mat[r][c])
                }
            }
            curRows.sort()
            if curRows.count > k {
                curRows.removeSubrange(k...curRows.count-1)
            }
            lastMinRows = curRows
        }
        
        return lastMinRows[k-1]
    }
}
