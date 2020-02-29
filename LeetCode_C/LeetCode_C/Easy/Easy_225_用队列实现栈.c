//
//  Easy_225_用队列实现栈.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/3/1.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/// 双队列两种，分别在入栈或出栈时处理
/// 单队列一种方法，入栈时颠倒队列，把之前的出了再入。

#define maxSize 100
typedef struct {
    int data[maxSize];
    int front;
    int rear;
} MyQueue;

MyQueue* createQueue(){
    MyQueue *q = (MyQueue *)malloc(sizeof(MyQueue));
    q->front = 0;
    q->rear = 0;
    return q;
}

int queueSize(MyQueue *queue) {
    return ((queue->rear + maxSize)-queue->front) % maxSize;
}

bool enQueue(int value, MyQueue *queue) {
    if ((queue->rear+1)%maxSize == queue->front) {// 队满
        return false;
    }
    queue->data[(queue->rear++)%maxSize] = value;
    return true;
}

int outQueue(MyQueue *queue) {
    if (queue->front == queue->rear) {
        return 0;
    } else {
        return queue->data[(queue->front++)%maxSize];
    }
}

int getHead(MyQueue *queue) {
    return queue->data[queue->front];
}

bool isEmptyQueue(MyQueue queue) {
    return (queue.front == queue.rear);
}

typedef struct {
    MyQueue *list1;
    MyQueue *list2;
} MyStack;

/** Initialize your data structure here. */

MyStack* myStackCreate() {
    MyStack *stack = (MyStack *)malloc(sizeof(MyStack));
    stack->list1 = createQueue();
    return stack;
}

/** Push element x onto stack. */
void myStackPush(MyStack* obj, int x) {
    enQueue(x, obj->list1);
}

/** Removes the element on top of the stack and returns that element. */
int myStackPop(MyStack* obj) {
    obj->list2 = createQueue();
    while (queueSize(obj->list1) > 1) {
        enQueue(outQueue(obj->list1), obj->list2);
    }
    int num = outQueue(obj->list1);
    while (!isEmptyQueue(*obj->list2)) {
        enQueue(outQueue(obj->list2), obj->list1);
    }
    return num;
}

/** Get the top element. */
int myStackTop(MyStack* obj) {
    obj->list2 = createQueue();
    while (queueSize(obj->list1) > 1) {
        enQueue(outQueue(obj->list1), obj->list2);
    }
    int num = outQueue(obj->list1);
    enQueue(num, obj->list2);
    while (!isEmptyQueue(*obj->list2)) {
        enQueue(outQueue(obj->list2), obj->list1);
    }
    return num;
}

/** Returns whether the stack is empty. */
bool myStackEmpty(MyStack* obj) {
    return isEmptyQueue(*obj->list1);
}

void myStackFree(MyStack* obj) {
    free(obj);
}
