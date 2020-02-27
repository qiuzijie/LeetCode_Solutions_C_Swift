//
//  Easy_108_将有序数组转换为二叉搜索树.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/24.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

/// 升序数组
/// 可以把该问题看做 根据中序遍历序列创建二叉搜索树。
struct TreeNode* helper(int* nums, int low, int high){
    if (low <= high) {
        struct TreeNode *node = (struct TreeNode *)malloc(sizeof(struct TreeNode));
        int middle = (low+high)/2;
        node->val = nums[middle];
        node->left = helper(nums, low, middle-1);
        node->right = helper(nums, middle+1, high);
        return node;
    } else {
        return NULL;
    }
}

struct TreeNode* sortedArrayToBST(int* nums, int numsSize){
    struct TreeNode *tree = helper(nums, 0, numsSize-1);
    return tree;
}

