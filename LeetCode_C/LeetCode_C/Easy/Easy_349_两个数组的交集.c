//
//  Easy_349_两个数组的交集.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/25.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int compare (const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int* intersection(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    *returnSize = 0;
    if (nums1Size < 1 || nums2Size < 1) {
        int *a = malloc(sizeof(int));
        return a;
    }
    qsort(nums1, nums1Size, sizeof(int), compare);
    qsort(nums2, nums2Size, sizeof(int), compare);
    int i = 0, j = 0;
    int a=0,b=0;
    while (i<nums1Size && j<nums2Size) {
        a = nums1[i];
        b = nums2[j];
        if (a == b) {
            if (*returnSize == 0 || a!=nums1[*returnSize-1]) {
                nums1[(*returnSize)++] = a;
            }
            i++;
            j++;
        } else if (a < b) {
            i++;
        } else {
            j++;
        }
    }
    return nums1;
}
