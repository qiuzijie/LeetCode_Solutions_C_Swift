//
//  Easy_155_最小栈.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/3/3.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>


typedef struct {
    int data[100];
    int helper[100];
    int front;
} MinStack;

/** initialize your data structure here. */

MinStack* minStackCreate() {
    MinStack *stack = (MinStack *)malloc(sizeof(MinStack));
    stack->front = 0;
    return stack;
}

void minStackPush(MinStack* obj, int x) {
    int curMin = x;
    if (obj->front > 0) {
        curMin = obj->helper[obj->front-1];
    }
    
    if (x < curMin) {
        obj->helper[obj->front] = x;
    } else {
        obj->helper[obj->front] = curMin;
    }
    obj->data[obj->front++] = x;
}

void minStackPop(MinStack* obj) {
    obj->front--;
}

int minStackTop(MinStack* obj) {
    return obj->data[obj->front-1];
}

int minStackGetMin(MinStack* obj) {
    return obj->helper[obj->front-1];
}

void minStackFree(MinStack* obj) {
    free(obj);
}

/**
 * Your MinStack struct will be instantiated and called as such:
 * MinStack* obj = minStackCreate();
 * minStackPush(obj, x);
 
 * minStackPop(obj);
 
 * int param_3 = minStackTop(obj);
 
 * int param_4 = minStackGetMin(obj);
 
 * minStackFree(obj);
*/
