//
//  Easy_104_二叉树的最大深度.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/6/17.
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

#pragma mark- 递归
int depth(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }
    if (root->left == NULL && root->right == NULL) {
        return 1;
    }
    int a = depth(root->left)+1;
    int b = depth(root->right)+1;
    return a>b?a:b;
}

int maxDepth(struct TreeNode* root){
    return depth(root);
}

#pragma mark- 栈
typedef struct {
    struct TreeNode * data[10000];
    int front;
} SqStack;

void push(struct TreeNode *node, SqStack *stack){
    stack->data[++stack->front] = node;
}

struct TreeNode * pop(SqStack *stack){
    if ((*stack).front == -1) {
        return NULL;
    }
    return (*stack).data[(*stack).front--];
}

bool isEmptyStack(SqStack *stack){
    return (*stack).front == -1;
}

int maxDepth1(struct TreeNode* root){
    SqStack *s = (SqStack *)malloc(sizeof(SqStack));
    (*s).front = -1;
    
    int maxDepth = 0;
    root->currentDepth = 1;
    push(root, s);

    if (isEmptyStack(s)) {
        struct TreeNode *node = pop(s);
        int c = node->currentDepth;
        if (c > maxDepth) {
            maxDepth = c;
        }
        if ((*node).left) {
            (*node).currentDepth = c++;
            push((*node).left, s);
        }
        if ((*node).right) {
            (*node).currentDepth = c++;
            push((*node).right, s);
        }
    }
    return maxDepth;
}


#pragma mark- 队列

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

int maxDepth2(struct TreeNode* root){
    if (!root) {
        return 0;
    }
    SqQueue s;
    s.rear = s.front = 0;
    enQueue(root, &s);
    int count = 1;
    int oldLevelCount = 1;
    int currentLevelCount = 0;
    while (!isEmptyQueue(s)) {
        struct TreeNode *node = outQueue(&s);
        if (node->left != NULL) {
            currentLevelCount++;
            enQueue(node->left, &s);
        }
        if (node->right != NULL) {
            currentLevelCount++;
            enQueue(node->right, &s);
        }
        oldLevelCount--;
        if (oldLevelCount == 0 && currentLevelCount > 0) {
            count++;
            oldLevelCount = currentLevelCount;
            currentLevelCount = 0;
        }
    }
    return count;
}
