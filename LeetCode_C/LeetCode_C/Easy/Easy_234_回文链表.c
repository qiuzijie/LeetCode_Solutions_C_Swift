//
//  Easy_234_回文链表.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/6/5.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

// 找中点
bool isPalindrome(struct ListNode* head){
    if (!head || !head->next) {
        return true;
    }

    struct ListNode *fast = head;
    struct ListNode *slow = head;
    
    // 快慢指针找中点
    while (fast && fast->next) {
        fast = fast->next->next;
        slow = slow->next;
    }
    
    //反转后一半
    struct ListNode *middle = NULL;
    struct ListNode *temp = NULL;
    while (slow) {
        temp = slow->next;
        slow->next = middle;
        middle = slow;
        slow = temp;
    }
    
    while (middle) {
        if (middle->val != head->val) {
            return false;
        }
        middle = middle->next;
        head = head->next;
    }
    return true;
}


typedef struct Stack{
    int *data;
    int top;
} Stack;

void push(Stack *S, int value) {
    (*S).top++;
    if ((*S).top == 0) {
        (*S).data = (int *)malloc(sizeof(int));
    } else {
        (*S).data = (int *)realloc((*S).data, ((*S).top+1)*sizeof(int));
    }
    (*S).data[(*S).top] = value;
}

int pop(Stack *S) {
    if ((*S).top == -1) {
        return NULL;
    }
    return (*S).data[(*S).top--];
}

// 栈  超过内存限制
bool isPalindrome1(struct ListNode* head){
    if (!head || !head->next) {
        return true;
    }
    struct ListNode* temp = head;
    Stack s;
    s.top = -1;
    while (temp) {
        push(&s, temp->val);
        temp = temp->next;
    }
    while (head) {
        if (pop(&s) != head->val) {
            return false;
        }
        head = head->next;
    }
    
    return true;
}
