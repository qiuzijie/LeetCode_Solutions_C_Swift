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
