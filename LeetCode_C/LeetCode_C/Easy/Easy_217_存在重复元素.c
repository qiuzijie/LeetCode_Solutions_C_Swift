//
//  Easy_217_存在重复元素.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/19.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

// 暴力 超时
bool containsDuplicate(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[j] == nums[i]) {
                return true;
            }
        }
    }
    return false;
}

// 先排序
int compare (const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

bool containsDuplicate2(int* nums, int numsSize) {
    if (numsSize < 2) {
        return false;
    }
    qsort(nums, numsSize, sizeof(int), compare);
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i-1]) {
            return true;
        }
    }
    return false;
}

