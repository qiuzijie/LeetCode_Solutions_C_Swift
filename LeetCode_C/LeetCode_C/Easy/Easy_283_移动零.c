//
//  Easy_283_移动零.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/5.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

void moveZeroes(int* nums, int numsSize){
    int k = 0;
    for (int i = 0; k < numsSize; i++) {
        if (i >= numsSize) {
            nums[k] = 0;
            k++;
        } else if (nums[i] != 0) {
            nums[k] = nums[i];
            k++;
        }
    }
}
