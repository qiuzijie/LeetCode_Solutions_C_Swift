//
//  Easy_350_两个数组的交集2.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/28.
//  Copyright © 2019 qiuzijie. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int compare (const void *a, const void *b) {
    int aa = *(int *)a;
    int bb = *(int *)b;
    if (aa > bb) {
        return 1;
    } else {
        return -1;
    }
    return 0;
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
            nums1[(*returnSize)++] = a;
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

int* intersection2(int* nums1, int nums1Size, int* nums2, int nums2Size, int* returnSize) {
    int *min, *max;
    int min_size=0, max_size=0;
    if (nums1Size < nums2Size) {
        min = nums1;
        max = nums2;
        min_size = nums1Size;
        max_size = nums2Size;
    } else {
        min = nums2;
        max = nums1;
        min_size = nums2Size;
        max_size = nums1Size;
    }
    
    int *min_tag = (int *)malloc(min_size*sizeof(int));
    int *max_tag = (int *)malloc(max_size*sizeof(int));
    
    for (int i = 0; i < min_size; i++) {
        min_tag[i] = 0;
    }
    for (int i = 0; i < max_size; i++) {
        max_tag[i] = 0;
    }
    
    *returnSize = 0;
    for (int i = 0; i < min_size; i++) {
        for (int j = 0; j < max_size; j++) {
            if (min[i] == max[j] && min_tag[i] == 0 && max_tag[j] == 0) {
                min_tag[i] = 1;
                max_tag[j] = 1;
                (*returnSize)++;
            }
        }
    }
    
    int *nums = (int *)malloc(*returnSize *sizeof(int));
    int k = 0;
    for (int i = 0; i < min_size; i++) {
        if (min_tag[i] == 1) {
            nums[k++] = min[i];
        }
    }
    return nums;
}
