//
//  Middle_213_打家劫舍2.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/29.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>

int max(int a, int b) {
    return ((a > b) ?a:b);
}

// 首尾不能都抢，看成分别包含首尾的两排房子
int rob(int* nums, int numsSize){

    if (numsSize > 2) {
        int nums2[numsSize];
        for (int i = 0; i < numsSize; i++) {
            nums2[i] = nums[i];
        }
        int maxNum = max(nums[0], nums[1]);
        nums[1] = maxNum;
        for (int i = 2; i < numsSize-1; i++) {
            nums[i] = max(nums[i]+nums[i-2],nums[i-1]);
            if (nums[i] > maxNum) {
                maxNum = nums[i];
            }
        }
        int maxNum2 = max(nums2[1], nums2[2]);
        nums2[2] = maxNum2;
        for (int i = 3; i < numsSize; i++) {
            nums2[i] = max(nums2[i]+nums2[i-2],nums2[i-1]);
            if (nums2[i] > maxNum2) {
                maxNum2 = nums2[i];
            }
        }
        return max(maxNum, maxNum2);
    }
    if (numsSize == 1) {
        return nums[0];
    }
    if (numsSize == 2) {
        return max(nums[0],nums[1]);
    }
    return 0;
}
