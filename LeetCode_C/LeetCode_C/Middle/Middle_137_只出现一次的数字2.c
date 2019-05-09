//
//  Middle_137_只出现一次的数字2.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/25.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int singleNumber(int* nums, int numsSize) {
    int a = 0;
    for (int i = 0; i < numsSize; i++) {
        a = a^nums[i];
    }
    return a;
}
