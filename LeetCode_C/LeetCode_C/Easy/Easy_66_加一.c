//
//  Easy_66_加一.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/5.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>


int* plusOne(int* digits, int digitsSize, int* returnSize){
    *returnSize = digitsSize;
    for (int i = digitsSize-1; i >= 0; i--) {
        if (digits[i] == 9) {
            digits[i] = 0;
        } else {
            digits[i] = digits[i] + 1;
            break;
        }
    }
    
    if (digits[0] == 0) {
        int *nums = (int *)malloc(sizeof(int)*(digitsSize+1));
        nums[0] = 1;
        for (int i = 1; i <= digitsSize; i++) {
            nums[i] = digits[i-1];
        }
        *returnSize+=1;
        return nums;
    } else {
        return digits;
    }
}

