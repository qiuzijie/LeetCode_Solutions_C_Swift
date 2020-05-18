//
//  Hard.swift
//  LeetCode_Swift
//
//  Created by qiuzijie on 2020/3/25.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

import Foundation

// MARK: - N皇后 回溯 ***
private var results = [Int](repeating: 0, count: 8)
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


// MARK: - 224 基本计算器
let priorityMap = ["+":1,"-":1,"*":2,"/":2,"(":0,")":3]

func higherPriority(_ c1: String, _ c2: String) -> Bool {
    return priorityMap[c1]! > priorityMap[c2]!
}

func math(_ c: String, _ n1: Int, _ n2: Int) -> Int {
    switch c {
    case "+":
        return (n1+n2)
    case "-":
        return (n1-n2)
    case "*":
        return (n1*n2)
    case "/":
        return (n1/n2)
    default:
        return 0
    }
}

// 利用栈硬写
func calculate(_ s: String) -> Int {
    // 记录符号
    var s1 = [String]()
    // 记录数字
    var s2 = [Int]()
    
    var ret = 0
    var temp = ""
    for str in s {
        if str <= "9" && str >= "0" {
            temp += String(str)
        } else {
            if temp.count > 0 {
                s2.append(Int(temp)!)
                temp = ""
            }
            if str == " " {
                continue
            } else if str == "(" {
                s1.append(String(str))
                continue
            } else if str == ")" {
                // 遇到右括号，将括号之间的运算符全部出栈
                while s1.last != "(" {
                    let n2 = s2.removeLast()
                    let n1 = s2.removeLast()
                    let c = s1.removeLast()
                    let temp = math(c, n1, n2)
                    s2.append(temp)
                }
                // 移除左括号
                s1.removeLast()
                continue
            }

            // 如果栈顶优先级高于或等于当前运算符就出栈进行运算
            while s1.count > 0 && !higherPriority(String(str), s1.last!) {
                // 从数字栈出两个
                let n2 = s2.removeLast()
                let n1 = s2.removeLast()
                let c = s1.removeLast()
                let temp = math(c, n1, n2)
                s2.append(temp)
            }
            s1.append(String(str))
        }
    }
    
    if temp.count > 0 {
        s2.append(Int(temp)!)
    }

    while s1.count > 0 {
        let c = s1.removeLast()
        let n2 = s2.removeLast()
        let n1 = s2.removeLast()
        ret = math(c, n1, n2)
    }
    if s2.count > 0 {
        ret = s2[0]
    }
    
    return ret
}


// MARK: - 23. 合并K个排序链表
class Solution23 {
    
    // 利用优先级队列（堆）
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {

        var minQueue = [ListNode]()
        for node in lists {
            heapInsert(node, &minQueue)
        }
        
        let dummy = ListNode(0)
        var node = dummy
        
        while !minQueue.isEmpty {
            let min = popPeek(&minQueue)
            if let n = min.next {
                heapInsert(n, &minQueue)
            }
            node.next = min
            node = node.next!
        }
        
        return dummy.next
    }
    // 构造小顶堆
    func heapInsert(_ node: ListNode?, _ list: inout [ListNode]) {
        if let node = node {
            list.append(node)
            var curIdx = list.count-1
            // 自下而上调整
            while curIdx > 0 && list[(curIdx-1)/2].val > list[curIdx].val {
                list.swapAt((curIdx-1)/2, curIdx)
                curIdx = (curIdx-1)/2
            }
        }
    }
    
    func popPeek(_ list: inout [ListNode]) -> ListNode {
        let peek = list.first
        if list.count > 1 {
            list[0] = list.last!
        }
        list.removeLast()
        var curIdx = 0
        while true {
            let lc = (curIdx+1)*2-1 // 左孩子
            let lr = (curIdx+1)*2 // 右孩子
            var target = curIdx
            if lc <= list.count-1 && list[lc].val < list[curIdx].val {
                target = lc
            }
            if lr <= list.count-1 && list[lr].val < list[target].val {
                target = lr
            }
            if target == curIdx {
                break
            } else {
                list.swapAt(curIdx, target)
                curIdx = target
            }
        }
        return peek!
    }
}

// MARK: - 25. K 个一组翻转链表
/*
 不足k个不翻转。常数的额外空间。
 */
class Solution25 {
    /*
     得到链表长度，用于判断啥时候结束翻转
     原地翻转
     */
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var length = 0
        var node = head
        while node != nil {
            node = node?.next
            length += 1
        }
        if length < k || k < 2 {
            return head
        }
        let dummy = ListNode(0)
        dummy.next = head
        var pre = dummy
        var curNode = head
        var tempK = k-1
        
        while curNode?.next != nil {
            let temp = curNode?.next!
            curNode?.next = temp?.next
            temp?.next = pre.next
            pre.next = temp
            tempK -= 1
            if tempK == 0 {// 开始下一组翻转
                length -= k
                if length < k {
                    break;
                }
                tempK = k-1
                pre = curNode!
                curNode = curNode?.next
            }
        }
        
        return dummy.next
    }
}
