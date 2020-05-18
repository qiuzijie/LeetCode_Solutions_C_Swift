//
//  Easy.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2019/4/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

import Foundation

//MARK: - 121
func maxProfit (from prices : [Int]) -> Int {
    if prices.count < 2 {
        return 0
    }
    var m = prices[0]
    var maxProfit = 0
    for i in 1..<prices.count {
        m = min(m, prices[i])
        maxProfit = max(maxProfit, prices[i]-m)
    }
    return maxProfit;
}

//MARK: - 122
func maxProfit1 (from prices : [Int]) -> Int {
    if prices.count < 2 {
        return 0;
    }
    var profit = 0;
    for i in 1..<prices.count {
        if prices[i] > prices[i-1]{
            profit += prices[i] - prices[i-1];
        }
    }
    return profit;
}

// MARK: - 189
func rotate(_ nums: inout [Int], _ k: Int) {
    for _ in 0..<k {
        let n = nums.popLast()
        nums.insert(n!, at: 0)
    }
}

func rotate1(_ nums: inout [Int], _ k: Int) {
    if k % nums.count < 1{return}
    var k = k % nums.count
    nums.reverse()
    nums[0..<k].reverse()
    nums[k..<nums.count].reverse()
}

// MARK: - 217

func containsDuplicate(_ nums: [Int]) -> Bool {
    let s = Set(nums)
    return (s.count != nums.count)
}

func containsDuplicate2(_ nums: [Int]) -> Bool {
    if nums.count < 2 {
        return false;
    }
    let sorts = nums.sorted()
    for i in 1..<sorts.count {
        if sorts[i] == sorts[i-1] {
            return true;
        }
    }
    return false;
}

// 超时
func containsDuplicate3(_ nums: [Int]) -> Bool {
    if nums.count < 2 {
        return false
    }
    var temps = nums;
    for i in 0..<nums.count {
        temps.remove(at: 0)
        if temps.contains(nums[i]) {
            return true
        }
    }
    return false
}

func containsDuplicate4(_ nums: [Int]) -> Bool {
    if nums.count < 2 {
        return false
    }
    var dic = [Int: Int]()
    for n in nums {
        if dic[n] == 1 {
            return true;
        } else {
            dic[n] = 1;
        }
    }
    return false;
}


// MARK: - 136
func singleNumber(_ nums: [Int]) -> Int {
    var dic:[Int: Int] = [:]
    for n in nums {
        if dic[n] == nil {
            dic[n] = 1;
        } else {
            dic[n] = nil;
        }
    }
    return dic.keys.first!
}

func singleNumber2(_ nums: [Int]) -> Int {
    var s = Set<Int>()
    for n in nums {
        if s.contains(n) {
            s.remove(n)
        } else {
            s.insert(n)
        }
    }
    return s.first!
}

// MARK: - 349
func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    let s1 = Set(nums1)
    let s2 = Set(nums2)
    return Array(s1.intersection(s2))
}

// MARK: - 350
func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var nums = [Int]()
    var nums22 = Array(nums2)
    for n in nums1 {
        if let i = nums22.firstIndex(of: n) {
            nums22.remove(at: i)
            nums.append(n)
        }
    }
    return nums
}

func intersect2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var nums22 = Array(nums2)
    let nums = nums1.filter { (n) -> Bool in
        if let index = nums22.firstIndex(of:n) {
            nums22.remove(at: index)
            return true
        } else {
            return false;
        }
    }
    return nums
}

func intersect3(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var dic = [Int: Int]()
    var nums = [Int]()
    for n in nums1 {
        if let a = dic[n] {
            dic[n] = a+1;
        } else {
            dic[n] = 1;
        }
    }
    for n in nums2 {
        if let a = dic[n] {
            if a > 0 {
                nums.append(n)
                dic[n] = a-1
            }
        }
    }
    return nums
}

// MARK: - 350
// 当数组数量超过最大整数位数时失效
func plusOne(_ digits: [Int]) -> [Int] {
    var number: UInt64 = 0
    var temp: UInt64 = 1
    
    for i in 0..<digits.count {
        let index = digits.count-i-1
        number += UInt64(digits[index])*temp
        temp *= 10
    }
    
    number+=1
    var nums: [Int] = Array()
    while number > 0 {
        let n = Int(number % 10)
        nums.append(n)
        number /= 10
    }
    nums.reverse()
    return nums
}

func plusOne2(_ digits: [Int]) -> [Int] {
    var nums = Array(digits)
    for i in 0..<digits.count {
        let index = digits.count-i-1
        if nums[index] == 9 {
            nums[index] = 0
        } else {
            nums[index] += 1
            break;
        }
    }
    if nums[0] == 0 {
        nums.insert(1, at: 0)
    }
    return nums
}

// MARK: - 283

func moveZeros(from nums: inout [Int]) {
    let count = nums.count
    while let i = nums.firstIndex(of: 0) {
        nums.remove(at: i)
    }
    for _ in nums.count..<count {
        nums.append(0)
    }
}

func moveZeros2(from nums: inout [Int]) {
    var k = 0
    for (i, n) in nums.enumerated() {
        if n == 0 {
            nums.remove(at: i-k)
            nums.append(0)
            k += 1
        }
    }
}

// MARK: - 1

// 贼慢
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var array = Array<Int>()
    for i in 0..<nums.count {
        let find = target - nums[i]
        let j = nums.lastIndex(of: find)
        if (j != nil && j != i) {
            array[0] = i
            array[1] = j!
            break;
        }
    }
    return array
}

// 一遍 hash 很不错
func twoSum2(nums: [Int], target: Int) -> [Int] {
    var dic = Dictionary<Int, Int>()
    for i in 0..<nums.count {
        let find = target - nums[i]
        if let j = dic[find] {
            return [j,i]
        } else {
            dic[nums[i]] = i
        }
    }
    return []
}

// MARK:- 344
func reverseString(_ s: inout [Character]) {
    s.reverse()
}

// MARK:- 7

func reverse(_ x: Int) -> Int {
    var str = String(x)
    var temp: Int = 0
    while str.count > 0 {
        let c = str.popLast()
        if c != "-" {
            temp = temp*10 + Int(String(c!))!
        } else {
            temp = -temp;
        }
    }
    if temp > Int32.max || temp < Int32.min {
        return 0
    }
    return temp
}

// MARK: - 387 字符串中的第一个唯一字符

// 超时
func firstUniqChar(_ s: String) -> Int {
    var str = s
    while str.count > 0 {
        let c = str.removeFirst()
        if !str.contains(c) {
            return s.firstIndex(of: c)!.utf16Offset(in: s)
        } else {
            while let i = str.firstIndex(of: c) {
                str.remove(at: i)
            }
        }
    }
    return -1
}

func firstUniqChar2(_ s: String) -> Int {
    var dic = [Character: Int]()
    let chars = Array(s)
    for c in chars {
        dic[c] = (dic[c] ?? 0) + 1
    }

    for (index, value) in s.enumerated() {
        if dic[value] == 1 {
            return index
        }
    }
    return -1
}

func firstUniqChar3(_ s: String) -> Int {
    for (index, value) in s.enumerated() {
        if s.firstIndex(of: value) == s.lastIndex(of: value) {
            return index;
        }
    }
    return -1
}

// MARK: - 242 有效的字母异位词
func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    var sortedS = s.sorted()
    var sortedT = t.sorted()
    while sortedS.count > 0 {
        if sortedS.removeFirst() != sortedT.removeFirst() {
            return false
        }
    }
    return true
}

func isAnagram1(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    var dic = [Character: Int]()
    for c in s {
        dic[c] = (dic[c] ?? 0)+1
    }
    for c in t {
        dic[c] = (dic[c] ?? 0)-1
        if dic[c] == -1 {
            return false
        }
    }
    for v in dic.values {
        if v > 0 {
            return false
        }
    }
    return true
}

func isAnagram2(_ s: String, _ t: String) -> Bool {
    let chars_S = s.unicodeScalars
    var counter_S = Array(repeating: 0, count: 26)
    let chars_T = t.unicodeScalars
    var counter_T = Array(repeating: 0, count: 26)
    
    for char in chars_S {
        let index = Int(char.value - 97)
        counter_S[index] += 1
    }
    
    for char in chars_T {
        let index = Int(char.value - 97)
        counter_T[index] += 1
    }
    
    return counter_T == counter_S
}

// MARK: - 125 验证回文字符串

func isPalindrome(_ s: String) -> Bool {
    let str = String(s).lowercased()
    var array = [Character]()
    for c in str {
        if c.isNumber || c.isCased {
            array.append(c)
        }
    }
    if array == array.reversed() {
        return true
    }
    return false
}

// MARK: - 28 实现strStr()
// 超时
func strStr(_ haystack: String, _ needle: String) -> Int {
    if needle.count == 0 {
        return 0
    }
    if let range = haystack.range(of: needle) {
        let nsRange = NSRange(range, in: haystack)
        return nsRange.location
//        return range.lowerBound.utf16Offset(in: haystack)
//        return haystack.distance(from:haystack.startIndex, to:range.lowerBound)
    }
    return -1
}

func strStr1(_ haystack: String, _ needle: String) -> Int {
    if needle.count == 0 {
        return 0
    }
    for (i,_) in haystack.enumerated(){
        if haystack.count - i < needle.count {
            return -1
        }
        let range = haystack.index(haystack.startIndex, offsetBy: i)..<haystack.index(haystack.startIndex, offsetBy: i+needle.count)
        let str = haystack[range]
        if str == needle {
            return i
        }
    }
    return -1
}

// RK 算法
// 超时，字符串特别长的时候，构造hash至少都需要O(m)
func strStr3(_ haystack: String, _ needle: String) -> Int {
    if haystack.count < needle.count {
        return -1
    }
    // 用来随机存取字符
    var characterList = [Character]()
    // 构造 haystack 的子字符串的hash值。
    // 构造 needle 的hash 值。
    var hashMap = [Int]()
    var curHash = 0
    var needleHash = 0
    needle.forEach { (c) in
        needleHash += Int(c.asciiValue! - Character("a").asciiValue!)
    }
    var count = 0
    let needleCount = needle.count// 这个也很耗时。。
    let haystackCount = haystack.count// 这个也很耗时。。
    haystack.forEach { (c) in
        characterList.append(c)
        if count < needleCount {
            curHash += Int(c.asciiValue! - Character("a").asciiValue!)
        }
        count += 1
    }
    hashMap.append(curHash)
    
    for i in 0...haystackCount-needleCount {
        if i > 0 {
            let prev = characterList[i-1].asciiValue! - Character("a").asciiValue!
            let last = characterList[i+needle.count-1].asciiValue! - Character("a").asciiValue!
            curHash = curHash-Int(prev)+Int(last)
        }
        // 哈希值相同才进行下一步判断
        if curHash == needleHash {
            var flag = true
            for j in i..<i+needle.count {
                // 每一位开始匹配
                let c1 = haystack[haystack.index(haystack.startIndex, offsetBy: j)]
                let c2 = needle[needle.index(needle.startIndex, offsetBy: j-i)]
                if c1 != c2 {
                    flag = false
                    break
                }
            }
            if flag {
                return i
            }
        }
    }
    return -1
}


// MARK: - 30 报数
func countAndSay(_ n: Int) -> String {
    var nums = [Int]()
    nums.append(1)
    for _ in 1...n {
        var temp = 0;
        var old = nums.first!
        var tempNums = [Int]()
        for j in 0..<nums.count {
            let number = nums[j]
            if number == old {
                temp += 1
            } else {
                tempNums.append(number)
                tempNums.append(temp)
                old = number
                temp = 1
            }
        }
        nums = tempNums
    }
    var str = String()
    for n in nums {
        str += String(n)
    }
    return str
}

// MARK: - 13 罗马数字转整数
func romanToInt(_ s: String) -> Int {
    let dic = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]
    var number = 0
    var pre = 0
    for c in s {
        let value = dic[String(c)]!
        if value > pre {
            number -= pre*2
        }
        number += value
        pre = value
    }
    return number
}

// MARK: - 191 位1的个数
// 依次把n的最后一个1反转为0，直到全部为0
// n的最后一个1的位置，n-1为0 按位或就行了
func hammingWeight(_ n: Int) -> Int {
    var count = 0
    var nn = n
    while nn > 0 {
        count += 1
        nn &= nn-1
    }
    return count
}

// 从 1 开始左移，按位与依次查看每一个位置是否为1
func hammingWeight2(_ n: Int) -> Int {
    var count = 0
    var flag = 1
    
    while flag <= n {
        if n&flag != 0 {
            count+=1
        }
        flag = flag << 1
    }
    return count
}

// MARK: -1013 将数组分成和相等的三个部分

/// 分成三份 相加
func canThreePartsEqualSum(_ A: [Int]) -> Bool {
    var sum = 0;
    A.forEach { (number) in
        sum += number;
    }

    if sum%3 != 0 {
        return false
    }
    let averge = sum/3
    var tempSum = 0;
    var flag = 0;
    for num in A {
        tempSum += num;
        if tempSum == averge {
            flag += 1
            tempSum = 0
        }
    }
    // [-1,1,-1,1,-1,1,-1,1] flag会大于3
    return (flag >= 3) ? true : false
}

// 左右指针法
// 先判断能否三等分 然后左右求和 当左右和相等时，剩余和必相等
func canThreePartsEqualSum2(_ A: [Int]) -> Bool {
    var sum = 0;
    A.forEach { (number) in
        sum += number;
    }
    if sum%3 != 0 {
        return false
    }
    var left = 0
    var right = A.count-1
    var sumL = A[left]
    var sumR = A[right]
    let averge = sum/3
    
    while left < right-1{
        if sumL == sumR && sumL == averge {
            return true
        }
        if sumL != averge{
            left+=1
            sumL += A[left]
        }
        if sumR != averge{
            right-=1
            sumR += A[right]
        }
    }
    return false
}

// MARK: -1071 字符串的最大公因子
func helper(_ checkStr: String, _ subStr: String) -> Bool {
    let length = subStr.count
    let rCount = checkStr.count / length
    for i in 0..<rCount {
        let begin = checkStr.index(checkStr.startIndex, offsetBy: i*length)
        let end = checkStr.index(begin, offsetBy: length-1)
        let temp = checkStr[begin...end]
        
        if String(temp) != subStr {
            return false
        }
    }
    return true
}

// 如果存在一个符合要求的字符串 X，那么也一定存在一个符合要求的字符串 X'，它的长度为 str1 和 str2 长度的最大公约数
func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    var checkStr = str1.count > str2.count ? str2:str1
    
    while checkStr.count > 0 {
        // 最大的公约数不满足，那么后面的公约数都不会满足
        if str1.count % checkStr.count == 0 && str2.count % checkStr.count == 0{
            if helper(str1, checkStr) && helper(str2, checkStr) {
                return checkStr
            }
        } else {
           return ""
        }
        checkStr.removeLast()
    }
    return ""
}

// 数学办法 1+2 = 2+1 这样两个字符串一定有公约字符串 然后求最大公约数 求出最大公约字符串
func gcdOfStrings2(_ str1: String, _ str2: String) -> String {
    if str1+str2 != str2+str1 {
        return ""
    }
    var a = str1.count
    var b = str2.count
    var gcd = 0
    // 辗转相除法
    while a > 0 && b > 0 {
        if a%b == 0 {
            gcd = b
            break
        } else {
            let temp = b
            b = a%b
            a = temp
        }
    }
    
    let end = str1.index(str1.startIndex, offsetBy: gcd-1)
    let begin = str1.startIndex
    return String(str1[begin...end])
}

// MARK: - 118 杨辉三角形
func generate(_ numRows: Int) -> [[Int]] {
    var array = [[Int]]()
    for i in 0..<numRows {
        array.append([Int]())
        for j in 0...i {
            let lastRow = i-1
            let lastLeft = j-1
            let lastRight = j
            var value = 1
            if lastRow >= 0 && lastLeft >= 0 {
                value = array[lastRow][lastLeft]
                if lastRight < i {
                    value += array[lastRow][lastRight]
                }
            }
            array[i].append(value)
        }
    }
    return array
}

// MARK: - 190 颠倒二进制位
// 每次取n最后一位，再左移到最前面
func reverseBits(_ n: Int) -> Int {
    var result = 0
    var vn = n
    for i in 0...31 {
        result += ((vn & 1) << (31-i))
        vn >>= 1
    }
    return result
}

// MARK: -20 有效的括号
func isValid(_ s: String) -> Bool {
    var stack = [Character]()
    
    for c in s {
        if c == "(" ||
            c == "{" ||
            c == "[" {
            stack.append(c)
        }
        if c == ")" ||
            c == "}" ||
            c == "]" {
            if stack.isEmpty {return false}
            let left = stack.popLast()
            if c == ")" && left != "(" {
                return false
            } else if c == "}" && left != "{" {
                return false
            } else if c == "]" && left != "[" {
                return false
            }
        }
    }
    return stack.isEmpty
}

// MARK: -268 缺失的数字
// O(n) O(n)
func missingNumber(_ nums: [Int]) -> Int {
    var dic = [Int:Int]()
    for n in nums {
        dic[n] = 1
    }
    for i in 0...nums.count {
        if dic[i] == nil {
            return i
        }
    }
    return 0
}

// 异或
// O(n) O(1)
func missingNumber2(_ nums: [Int]) -> Int {

    var missing = nums.count
    for i in 0..<nums.count {
        missing ^= i
        missing ^= nums[i]
    }
    return missing
}

// 数学
// O(n) O(1)
func missingNumber3(_ nums: [Int]) -> Int {

    var sum = nums.count
    for i in 0..<nums.count {
        sum += i
        sum -= nums[i]
    }
    return sum
}

// MARK: - 836 矩形重叠
// 投影到X/Y轴，若有一条边不相交则不重叠
// 矩形 rec1 和 rec2 的水平边投影到x轴上的线段分别为 (rec1[0], rec1[2]) 和 (rec2[0], rec2[2])。根据数学知识我们可以知道，当 min(rec1[2], rec2[2]) > max(rec1[0], rec2[0]) 时，这两条线段有交集。
func isRectangleOverlap(_ rec1: [Int], _ rec2: [Int]) -> Bool {
    return max(rec1[0], rec2[0]) < min(rec1[2], rec2[2]) && max(rec1[1], rec2[1]) < min(rec1[3], rec2[3])
}

// 四种情况两个矩形会不重叠 A位于B的左、右、上、下方
func isRectangleOverlap1(_ rec1: [Int], _ rec2: [Int]) -> Bool {
    if rec1[2] <= rec2[0] || rec1[0] >= rec2[2] {
        return false
    }
    if rec1[3] <= rec2[1] || rec1[1] >= rec2[3] {
        return false
    }
    return true
}

// MARK: - 17.16 按摩师 类似于打家劫舍

// dp 保留的是位于每个位置时的最大值
// O(n) 空间O(n)
func massage(_ nums: [Int]) -> Int {
    if nums.count < 1 {
        return 0
    }
    var dp = nums
    
    for i in 1..<nums.count {
        if i > 1 {
            dp[i] = max(dp[i]+dp[i-2], dp[i-1])
        } else {
            dp[i] = max(dp[0], dp[1])
        }
    }
    return dp[nums.count-1]
}

// 这个dp保留了以每个位置结束的最大值,就是把每种可能都算出来了
// O(n^2) 空间O(n)
func massage1(_ nums: [Int]) -> Int {
    var dp = [Int](repeating: 0, count: nums.count)
    var curmax = 0
    for (i,n) in nums.enumerated() {
        var cur = 0
        if i > 1 {
            for j in 0..<i-1 {
                cur = max(cur, dp[j])
            }
        }
        dp[i] = n+cur
        curmax = max(curmax, dp[i])
    }
    return curmax
}

// MARK: - 卡牌分组 914 *

func gcd(_ a: Int, _ b: Int) -> Int {
    if a == 0 {
        return b
    }
    return gcd(b%a, a)
}
// 用 map 记录分组数比排序之后遍历分要好
// O(n) 空间：O(n)
func hasGroupsSizeX(_ deck: [Int]) -> Bool {
    // 至少要2个
    if deck.count < 2 {
        return false
    }
    
    var groupMap = [Int: Int]()

    // 分组
    for count in deck {
        groupMap[count] = (groupMap[count] ?? 0) + 1
    }

    // 辗转相除，找最大公约数
    // 1 <= deck.length <= 10000
    var g = -1
    for count in groupMap.values {
        if g == -1 {
            g = count
        } else {
            g = gcd(g, count)
        }
    }
    if g < 2 {
        return false
    }
    return true
}

// MARK: - 994 腐烂的橘子 ***

/// 广度优先遍历 先将烂橘子入队 再遍历上下左右的格子找新鲜橘子
/// dis 辅助字典用来记录每个格子的腐烂所需时间。
func orangesRotting( _ grid: [[Int]]) -> Int {
    var newGrid = grid
    var queue = intQueue()
    let C = newGrid[0].count
    let R = newGrid.count
    var dis = [Int:Int]()
    var fresh = 0
    
    for i in 0..<R {
        for j in 0..<newGrid[i].count {
            if newGrid[i][j] == 2 {
                /// i*C + j 记录行列数 很好地办法
                queue.enQueue(i*C + j)
                dis[i*C+j] = 0
            } else if newGrid[i][j] == 1 {
                fresh += 1
            }
        }
    }
    var curDis = 0

    while !queue.isEmpty {
        let value = queue.deQueue()!
        let row = value/C
        let col = value%C
        curDis = dis[row*C+col] ?? 0
        for i in 0..<4 {
            var c = col
            var r = row
            if i == 0 {
                r -= 1
            } else if i == 1 {
                r += 1
            } else if i == 2 {
                c -= 1
            } else if i == 3 {
                c += 1
            }
            if r >= 0 && r < R && c >= 0 && c < C && newGrid[r][c] == 1{
                dis[r*C+c] = curDis + 1
                newGrid[r][c] = 2
                queue.enQueue(r*C+c)
                fresh -= 1
            }
        }
    }
    
    if fresh == 0 {
        return curDis
    }
    return -1
}

// MARK: 575 分糖果1
func distributeCandies(_ candies: [Int]) -> Int {
    let s = Set(candies)
    return min(s.count, candies.count/2)
}
// MARK: 1103 分糖果2

func distributeCandies(_ candies: Int, _ num_people: Int) -> [Int] {
    var result = [Int]()
    var total = candies
    var curNum = 1
    var curPeo = 0
    while total > 0 || curPeo < num_people {
        if total <= 0 {
            result.append(0)
        } else if curPeo < num_people {
            result.append(curNum)
        } else {
            result[curPeo%num_people] += curNum
        }
        total -= curNum
        curNum = min(curNum+1, total)
        curPeo = curPeo + 1
    }
    return result
}

// MARK: - 面试题57 和为s的连续正数序列
/// 暴力 o(n^2)
func findContinuousSequence(_ target: Int) -> [[Int]] {
    var result = [[Int]]()

    var tempList = [Int]()
    var tempSum = 0
    for i in 1..<(target+1)/2 {
        tempList.removeAll()
        tempSum = 0
        for j in i..<(target+1)/2 + 1 {
            tempSum += j
            if tempSum < target {
                tempList.append(j)
            } else if tempSum == target {
                tempList.append(j)
                result.append(tempList)
            } else {
                break
            }
        }
    }
    
    return result
}

// MARK: - 876 链表的中间结点

// 快慢指针
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    while fast != nil && fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
    }
    return slow
}

func middleNode1(_ head: ListNode?) -> ListNode? {
    // 链表长度 确定中点
    var node = head
    var length = 0
    while node != nil {
        length += 1
        node = node?.next
    }
    // 前一半出队
    node = head
    for _ in 0..<length/2 {
        node = node?.next
    }
    return node
}

// MARK: - 206 反转链表
func reverseList(_ head: ListNode?) -> ListNode? {
    
    let dummy = ListNode(0)
    dummy.next = head
    while head?.next != nil {
        let temp = head?.next
        head?.next = temp?.next
        temp?.next = dummy.next
        dummy.next = temp
    }
    return dummy.next
}

// MARK: - 496. 下一个更大元素 I

// 暴力 时间：O(n^2)
func nextGreaterElement1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var ret = nums1
    
    for (i,n1) in nums1.enumerated() {
        var cur = -1
        var flag = false
        for n2 in nums2 {
            if n2 == n1 {
                flag = true
            }
            if flag && n2 > n1 {
                cur = n2
                break;
            }
        }
        ret[i] = cur
    }
    
    return ret
}

// 单调栈 时间：O(n) 空间：O(n)

func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var ret = nums1
    
    // 通过单调栈 构造映射
    var map = [Int: Int]()
    var stack = intStack()
    // 这个for的时间复杂度为O(n+n-1) 即O(n)，因为出栈次数最多n-1次
    for n in nums2 {
        if stack.isEmpty {
            stack.push(n)
        } else {
            // 将小于n的元素全部出栈
            while !stack.isEmpty && n > stack.peek! {
                map[stack.pop()!] = n
            }
            stack.push(n)
        }
    }
    
    for i in 0..<nums1.count {
        ret[i] = map[nums1[i]] ?? -1
    }
    
    return ret
}

// MARK: - 371 两整数之和
class Solution371 {
    func getSum(_ a: Int, _ b: Int) -> Int {
        // 无进位加法
        var sum = a^b
        // 进位
        var carry = (a&b)<<1
        
        while carry != 0 {
            let temp = sum
            sum = sum^carry
            carry = (temp&carry)<<1
        }
        return sum
    }
}

// MARK: - 21. 合并两个有序链表
class Solution21 {
    // 递归 递归公示写不清楚
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard l1 != nil else {
            return l2
        }
        guard l2 != nil else {
            return l1
        }
        
        if l1!.val < l2!.val {
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1
        } else {
            l2?.next = mergeTwoLists(l2?.next, l1)
            return l2
        }
    }
    
    // 常规做法
    func mergeTwoLists1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var l1 = l1
        var l2 = l2
        var node = dummy
        while l1 != nil && l2 != nil {
            if l1!.val > l2!.val {
                node.next = l2
                l2 = l2?.next
            } else {
                node.next = l1
                l1 = l1?.next
            }
            node = node.next!
        }
        node.next = l1 != nil ? l1: l2
        return dummy.next
    }
}
// MARK: - 202 快乐数
/*
 int64有19位，假设每位为9，最大的每位平方和才 19*81 = 1539，所以肯定不会无限增大。
 所以要么最后变为1，要么会进入小于1539的循环中。
 终止条件为：循环或1
 */
public class Solution202 {
    func isHappy(_ n: Int) -> Bool {
        var map = [Int: Int]()
        var n = n
        while true {
            var cur = 0
            while n > 0 {
                let a = n%10
                cur += a*a
                n = n/10
            }
            if cur == 1 {
                return true
            } else if map[cur] != nil {
                return false
            }
            map[cur] = 1
            n = cur
        }
    }
}
