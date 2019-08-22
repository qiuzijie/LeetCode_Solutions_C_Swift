//
//  Easy_206_反转链表.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/28.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* reverseList(struct ListNode* head){
    struct ListNode *old = NULL;
    while (head) {
        struct ListNode *new = (struct ListNode *)malloc(sizeof(struct ListNode));
        new->val = head->val;
        new->next = old;
        old = new;
        head = head->next;
    }
    return old;
}

//
struct ListNode* reverseList1(struct ListNode* head){
    struct ListNode *dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode *cur = head;
    while (cur->next) {
        struct ListNode *temp = cur->next;
        cur->next = temp->next;
        temp->next = cur;
        dummy->next = temp;
    }
    return dummy->next;
}

// 递归
struct ListNode* reverseList2(struct ListNode* head){
    if (head == NULL || head->next == NULL) {
        return head;
    }
    struct ListNode *newHead = reverseList2(head->next);// 为最后一个节点
    head->next->next = head;
    head->next = NULL;
    return newHead;
}
