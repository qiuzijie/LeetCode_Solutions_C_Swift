//
//  Easy_88_合并两个有序数组.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/25.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

// 重新申请一个空间。。。
void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    int i = 0 , j = 0, k = 0;
    int* nums = (int *)malloc(sizeof(int)*(nums1Size+nums2Size));
    while (i < m && j < n) {
        if (nums1[i] < nums2[j]) {
            nums[k++] = nums1[i++];
        } else {
            nums[k++] = nums2[j++];
        }
    }
    while (i < m) {
        nums[k++] = nums1[i++];
    }
    while (j < n) {
        nums[k++] = nums2[j++];
    }
    
    for (int i = 0; i < k; i++) {
        nums1[i] = nums[i];
    }
}

// 蠢办法，插入法，每次还要挪位置
void merge1(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    int j = 0, k = 0;
    while (j < n && k < m) {
        if (nums2[j] < nums1[j+k]) {
            int a = nums1Size-1;
            while (a > j+k) {
                nums1[a] = nums1[a-1];
                a--;
            }
            nums1[j+k] = nums2[j];
            j++;
        } else {
            k++;
        }
    }
    while (j < n) {
        nums1[j+k] = nums2[j];
        j++;
    }
}

// 从尾部插入
void merge2(int* A, int ASize, int m, int* B, int BSize, int n){
    int i = m-1, j = n-1;
    while (i > -1 || j > -1) {
        if (i == -1) {
            A[--ASize] = B[j--];
        } else if (j == -1) {
            A[--ASize] = A[i--];
        } else {
            A[--ASize] = A[i] > B[j] ? A[i--]:B[j--];
        }
    }
}


// 先全部加入到数组1，然后再排序。。

char ** fizzBuzz(int n, int* returnSize){
    char **strArray = malloc(sizeof(char *)*n);
    for (int i = 1; i <= n; i++) {
        strArray[i-1] = i;
    }
    return strArray;
}
