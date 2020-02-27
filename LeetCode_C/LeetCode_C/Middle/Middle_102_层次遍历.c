//
//  Middle_101_层次遍历.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/8/29.
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

int** levelOrder(struct TreeNode* root, int* returnSize, int** returnColumnSizes){
    int row = 0, column = 0;
    int **array = (int **)malloc(sizeof(int *) * 10000);//分配指针数组，计算行的大小
    int *nums = (int *)malloc(sizeof(int) * 10000);
    
    returnColumnSizes[0] = (int *)malloc(sizeof(int) * 10000);
    SqQueue *queue = (SqQueue *)malloc(sizeof(SqQueue));
    
    if (root != NULL) {
        enQueue(root, queue);
    }
    int lastLevel = 1;
    int currentLevel = 0;
    while (!isEmptyQueue(*queue)) {
        struct TreeNode *node = outQueue(queue);
        lastLevel --;
        nums[column++] = node->val;
        if (lastLevel == 0) {
            returnColumnSizes[0][row] = column;
            array[row] = nums;
            nums = (int *)malloc(sizeof(int) * 10000);
            row++;
            column = 0;
        }
        
        if (node->left != NULL) {
            enQueue(node->left, queue);
            currentLevel++;
        }
        if (node->right != NULL) {
            enQueue(node->right, queue);
            currentLevel++;
        }
        if (lastLevel == 0 && currentLevel > 0) {
            lastLevel = currentLevel;
            currentLevel = 0;
        }
    }
    
    *returnSize = row;
    
    return array;
}

#pragma mark-

int** levelOrder1(struct TreeNode* root, int* returnSize, int** returnColumnSizes){
    struct TreeNode* queue[1000];
    int front = 0, rear = 0, last = 0;
    int currentRow = 0, currentColumn = 0;
    int **res = (int **)malloc(sizeof(int *) *1000);
    returnColumnSizes[0] = (int *)malloc(sizeof(int) *1000);
    
    if (root != NULL) {
        queue[rear++] = root;
    }
    last = rear;
    res[currentRow] = (int *)malloc(sizeof(int) *1000);
    while (front != rear) {
        struct TreeNode* node = queue[front++];
        res[currentRow][currentColumn++] = node->val;
        if (node->left != NULL) {
            queue[rear++] = node->left;
        }
        if (node->right != NULL) {
            queue[rear++] = node->right;
        }
        if (front == last) {
            returnColumnSizes[0][currentRow] = currentColumn;
            last = rear;
            currentRow++;
            currentColumn = 0;
            res[currentRow] = (int *)malloc(sizeof(int) *1000);
        }
    }
    *returnSize = currentRow;
    
    return res;
}
