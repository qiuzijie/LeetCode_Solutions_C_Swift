//
//  Easy_101_对称二叉树.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/8/27.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct TreeNode{
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
    int currentDepth;
};

#pragma mark- 迭代 广度搜索
typedef struct{
    struct TreeNode * data[10000];
    int front, rear;
} SqQueue;

void enQueue(struct TreeNode * T, SqQueue *Q){
    (*Q).data[(*Q).front++] = T;
}

struct TreeNode * outQueue(SqQueue *Q){
    return (*Q).data[(*Q).rear++];
}

bool isEmptyQueue(SqQueue Q){
    return (Q.front == Q.rear);
}

bool isSymmetric(struct TreeNode* root){
    if (root==NULL) {
        return true;
    }
    if (root->left == NULL && root->right == NULL) {
        return true;
    }
    if (root->left == NULL || root->right == NULL) {
        return false;
    }
    SqQueue leftQueue;
    leftQueue.front = leftQueue.rear = 0;
    enQueue(root->left, &leftQueue);
    SqQueue rightQueue;
    rightQueue.front = rightQueue.rear = 0;
    enQueue(root->right, &rightQueue);
    
    while (!isEmptyQueue(leftQueue) && !isEmptyQueue(rightQueue)) {
        struct TreeNode *leftNode = outQueue(&leftQueue);
        struct TreeNode *rightNode = outQueue(&rightQueue);
        if (leftNode->val != rightNode->val) {
            return false;
        }
        if (leftNode->left && rightNode->right){
            enQueue(leftNode->left, &leftQueue);
            enQueue(rightNode->right, &rightQueue);
        } else if (!(leftNode->left == NULL && rightNode->right == NULL)) {
            return false;
        }
        if (leftNode->right && rightNode->left){
            enQueue(leftNode->right, &leftQueue);
            enQueue(rightNode->left, &rightQueue);
        } else if (!(leftNode->right == NULL && rightNode->left == NULL)) {
            return false;
        }
    }
    if (!isEmptyQueue(leftQueue) || !isEmptyQueue(rightQueue)) {
        return false;
    }
    
    return true;
}

#pragma mark- 递归

bool helper(struct TreeNode* left, struct TreeNode* right){
    if (left && right) {
        if (left->val != right->val) {
            return false;
        }
        return (helper(left->left, right->right) && helper(left->right, right->left));
    } else if (!left && !right) {
        return true;
    }
    return false;
}

bool isSymmetric1(struct TreeNode* root){
    if (root == NULL) {
        return true;
    }
    return helper(root->left, root->right);
}
