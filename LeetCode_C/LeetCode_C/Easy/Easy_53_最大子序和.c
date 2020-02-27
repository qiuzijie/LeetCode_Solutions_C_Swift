//
//  Easy_53_最大子序和.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/27.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>

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
int max(int a, int b) {
    return ((a > b) ?a:b);
}

int maxSubArray1(int* nums, int numsSize){
    /// 当前元素位置的最大和
    int currentNum = nums[0];
    /// 所有的最大和
    int maxNum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        currentNum = max(currentNum, currentNum + nums[i]);
        maxNum = max(maxNum, currentNum);
    }
    return maxNum;
}
