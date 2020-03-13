//
//  Easy_543_二叉树的直径.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/3/10.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int max(int a, int b) {
    return a>b?a:b;
}

int depth(struct TreeNode *root){
    if (root == NULL) {
        return 0;
    }
    return max(depth(root->left),depth(root->right)) + 1;
}

// 错误解法！！！！！
// 任意两个节点之间的边数都可能是最大直径
// 最大的直径不一定包括根节点
int diameterOfBinaryTree(struct TreeNode* root){
    if (root == NULL) {
        return 0;
    }
    return depth(root->left) + depth(root->right);
}

int ans = 0;

int helper(struct TreeNode *root){
    if (root == NULL) {
        return 0;
    }
    int l = helper(root->left);
    int r = helper(root->right);
    ans = max(ans, l+r);
    return max(l, r) + 1;
}

/// 递归深度 height 时间复杂度O(n)
//  空间复杂度和递归深度为树的高度 等同于递归栈中最大的元素个数
int diameterOfBinaryTree2(struct TreeNode* root){
    helper(root);
    return ans;
}

int hammingWeight(uint32_t n) {
    int count = 0;
    while (n > 0) {
        if (n%10 == 1) {
            count++;
        }
        n = n/10;
    }
    return count;
}
