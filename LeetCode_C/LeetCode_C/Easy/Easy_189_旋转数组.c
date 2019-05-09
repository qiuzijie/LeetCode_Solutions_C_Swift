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
// [6,7,3,4,5,1,2]
// [6,7,1,2,5,3,4]
// [6,7,1,2,3,4,5]

// 循环交换 ：把最后k%n项挪到正确的位置上，和 0~k-1 上的数据进行交换。此时最后k项应该放在 k ~ 2k-1 上
// 每次将k个数据放在正确的位置上 然后处理 x*k ~ n 的数据
// 第一次交换完毕后，前 k 位数字位置正确，后 n-k 位数字中最后 k 位数字顺序错误，继续交换
// 待写

void rotate2(int* nums, int numsSize, int k) {
    int n = numsSize;
    k %= n;
    for (int start = 0; start < numsSize && k > 0; start += k, n -= k, k %= n) {
        for (int i = start; i < k+start; i++) {
            int temp = nums[i];
            nums[i] = nums[n+i-k];
            nums[n+i-k] = temp;
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

