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
