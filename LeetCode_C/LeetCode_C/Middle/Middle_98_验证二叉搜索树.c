//
//  Middle_98_验证二叉搜索树.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/8/22.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

struct TreeNode{
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#pragma mark- 递归
bool helper(struct TreeNode *root, double high, double low) {
    if (root == NULL) {
        return true;
    }
    
    int val = root->val;
    if (val >= high) return false;
    if (val <= low) return false;
    /// 重点 不能直接 return helper(root->left, val, low)
    if (!helper(root->left, val, low)) return false;
    if (!helper(root->right, high, val)) return false;
    return true;
}

bool isValidBST(struct TreeNode* root){
    return helper(root, __DBL_MAX__, -__DBL_MAX__);
}

#pragma mark- 迭代


#pragma mark- 中序遍历为升序

// 我写的蠢逼代码
void inOrder(struct TreeNode* T, double *preVal, bool *b){
    if (T) {
        inOrder(T->left,preVal,b);
        if (T->val <= *preVal) {
            *b = false;
            return;
        }
        *preVal = T->val;
        inOrder(T->right, preVal,b);
    }
}

bool isValidBST2(struct TreeNode* root){
    bool b = true;
    double preVal = -__DBL_MAX__;
    if (root == NULL) {
        return true;
    }
    inOrder(root,&preVal, &b);
    return b;
}

// 大神的代码

struct TreeNode *preNode;

bool inOrderVist(struct TreeNode *root){
    if (!root) {
        return true;
    }
    if (!inOrderVist(root->left)) {
        return false;
    }
    if (preNode && preNode->val >= root->val) {
        return false;
    }
    preNode = root;
    if (!inOrderVist(root->right)) {
        return false;
    }
    return true;
}

bool isValidBST3(struct TreeNode* root){
    preNode = NULL;
    return inOrderVist(root);
}

#pragma mark- 多重遍历

//广度遍历每个节点 节点大于左子节点的最右子节点 小于右子节点的最左子节点 那么此节点OK
bool isValidBST4(struct TreeNode* root){
    if (root == NULL) {
        return true;
    }
    struct TreeNode *node = root->left;
    while (node && node->right) {
        node = node->right;
    }
    if (node && node->val >= root->val) {
        return false;
    }
    node = root->right;
    while (node && node->left) {
        node = node->left;
    }
    if (node && node->val <= root->val) {
        return false;
    }
    return (isValidBST4(root->left) && isValidBST4(root->right));
}
