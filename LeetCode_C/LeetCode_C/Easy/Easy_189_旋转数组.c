//
//  Easy_189.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/18.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

//暴力 一轮轮的转圈
//O(kn) O(1)
void rotate1(int* nums, int numsSize, int k) {
    k = k % numsSize;
    for (int i = 0; i < k; i++) {
        int old = nums[numsSize-1];
        for (int j = numsSize-1; j > 0; j--) {
            nums[j] = nums[j-1];
        }
        nums[0] = old;
    }
}

// [1,2,3,4,5,6,7] 3 7
// [6,7,3,4,5,1,2] 处理 [3,4,5,1,2] 应该转动 3%5 = 3次
// [1,2,5,3,4] 处理 [5,3,4]
// [3,4,5] 处理[5] 当 k%n=0 时结束

// 循环交换
// 每次将最后 k 项放到 0~k-1 位置上，即前k项正确啦，然后对后面的 n-k 项做同样的操作
void rotate2(int* nums, int numsSize, int k) {
    int n = numsSize;
    k %= n;
    for (int start = 0; start < numsSize && k>0; start+=k,n-=k,k%=n) {
        for (int i = 0; i < k; i++) {
            int temp = nums[numsSize-k+i];
            nums[numsSize-k+i] = nums[start+i];
            nums[start+i] = temp;
        }
    }
}

void reverse(int *nums, int start, int end);
// 翻转
// O(n) O(1)
void rotate3(int* nums, int numsSize, int k) {
    k %= numsSize;
    reverse(nums, 0, numsSize-1);
    reverse(nums, 0, k-1);
    reverse(nums, k, numsSize-1);
}

void reverse(int *nums, int start, int end) {
    while (start < end) {
        int temp = nums[start];
        nums[start++] = nums[end];
        nums[end--] = temp;
    }
}

