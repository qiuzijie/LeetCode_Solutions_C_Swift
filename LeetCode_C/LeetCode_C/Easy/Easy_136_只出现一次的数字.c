//
//  Easy_136_只出现一次的数字.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/23.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// 异或
/*
 交换律：a ^ b ^ c <=> a ^ c ^ b
 任何数于0异或为任何数 0 ^ n => n
 相同的数异或为0: n ^ n => 0
 */
int singleNumber1(int* nums, int numsSize) {
    int a = 0;
    for (int i = 0; i < numsSize; i++) {
        a = a^nums[i];
    }
    return a;
}


int compare (const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}
// 先排序
int singleNumber2(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    
    for (int i = 0; i < numsSize; i++) {
        bool left = false;
        if (i-1 >= 0 && nums[i-1] == nums[i]) {
            left = true;
        }
        if (!left) {
            bool right = false;
            if (i+1 < numsSize && nums[i] == nums[i+1]) {
                right = true;
            }
            if (!right) {
                return nums[i];
            }
        }
    }
    return 0;
}
