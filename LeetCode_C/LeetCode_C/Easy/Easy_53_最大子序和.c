//
//  Easy_53_最大子序和.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/27.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>

int max(int a, int b) {
    return ((a > b) ?a:b);
}

/// 暴力
int maxSubArray(int* nums, int numsSize){
    int maxSum = 0;
    if (numsSize > 0) {
        maxSum = nums[0];
        for (int i = 0; i < numsSize; i++) {
            int sum = 0;
            for (int j = i; j < numsSize; j++) {
                sum += nums[i];
                if (sum > maxSum) {
                    maxSum = sum;
                }
            }
        }
    }
    return maxSum;
}


/// 贪心算法
int maxSubArray1(int* nums, int numsSize){
    /// 前一个元素位置的最大和
    int currentNum = nums[0];
    /// 所有的最大和
    int maxNum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        currentNum = max(currentNum, currentNum + nums[i]);
        maxNum = max(maxNum, currentNum);
    }
    return maxNum;
}


/// 动态规划
int maxSubArray2(int* nums, int numsSize){
    int maxSum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        /// 更新当前位置的最大子序和
        if (nums[i-1] > 0) {
            nums[i] += nums[i-1];
        }
        maxSum = max(maxSum, nums[i]);
    }
    return maxSum;
}
