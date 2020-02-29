//
//  Middle_384_打乱数组.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/29.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int *nums;
    int *shuffles;
    int numsSize;
} Solution;


Solution* solutionCreate(int* nums, int numsSize) {
    Solution *s = (Solution *)malloc(sizeof(Solution));
    s->nums = nums;
    s->shuffles = (int *)malloc(sizeof(int)*numsSize);
    s->numsSize = numsSize;
    srand((unsigned)time(NULL));
    return s;
}

/** Resets the array to its original configuration and return it. */
int* solutionReset(Solution* obj, int* retSize) {
    *retSize = obj->numsSize;
    return obj->nums;
}

/** Returns a random shuffling of the array. */
int* solutionShuffle(Solution* obj, int* retSize) {
    *retSize = obj->numsSize;
    int *copy = (int *)malloc(sizeof(int)*obj->numsSize);
    memcpy(copy,obj->nums,sizeof(int)*obj->numsSize);
    int *shuffles = obj->shuffles;
    for (int i = 0; i < obj->numsSize; i++) {
        int r = rand()%(obj->numsSize-i);
        shuffles[i] = copy[r];
        int temp = copy[obj->numsSize-i-1];
        copy[obj->numsSize-i-1] = copy[r];
        copy[r] = temp;
    }
 
    return obj->shuffles;
}

void solutionFree(Solution* obj) {
    free(obj);
}
