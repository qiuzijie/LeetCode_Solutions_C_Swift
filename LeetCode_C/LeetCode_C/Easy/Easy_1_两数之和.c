//
//  Easy_1_两数之和.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/6.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include "uthash.h"

int* twoSum(int* nums, int numsSize, int target, int* returnSize){
    int *array = (int *)malloc(sizeof(int)*2);
    for (int i = 0; i < numsSize-1; i++) {
        for (int j = i+1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                array[0] = i;
                array[1] = j;
                break;
            }
        }
    }
    *returnSize = 2;
    return array;
}

typedef struct hash_st{
    int id;
    int loc;
    UT_hash_handle hh;
} hash_st;

// 哈希表
int* twoSum2(int* nums, int numsSize, int target, int* returnSize){
    int *array = (int *)malloc(sizeof(int)*2);
    *returnSize = 2;
    
    hash_st *hash=NULL, *table=NULL;
    for (int i = 0; i < numsSize; i++) {
        hash = (hash_st *)malloc(sizeof(hash_st));
        hash->id = nums[i];
        hash->loc = i;
        HASH_ADD_INT(table, id, hash);
        hash = NULL;
    }
    for (int i = 0; i < numsSize; i++) {
        int find = target - nums[i];
        HASH_FIND_INT(table, &find, hash);
        if (hash) {
            if (hash->loc == i) {
                continue;
            }
            array[0] = i;
            array[1] = hash->loc;
            break;
        }
    }
    return array;
}
