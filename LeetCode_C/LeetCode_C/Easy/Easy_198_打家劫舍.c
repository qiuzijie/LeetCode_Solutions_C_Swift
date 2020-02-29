//
//  Easy_198_打家劫舍.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/29.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>

int max(int a, int b) {
    return ((a > b) ?a:b);
}

// 贪心 O(n)
int rob(int* nums, int numsSize){
    if (numsSize > 1) {
        int maxNum = max(nums[0], nums[1]);
        nums[1] = maxNum;
        for (int i = 2; i < numsSize; i++) {
            nums[i] = max(nums[i]+nums[i-2],nums[i-1]);
            if (nums[i] > maxNum) {
                maxNum = nums[i];
            }
        }
        return maxNum;
    }
    if (numsSize == 1) {
        return nums[0];
    }
    return 0;
}
