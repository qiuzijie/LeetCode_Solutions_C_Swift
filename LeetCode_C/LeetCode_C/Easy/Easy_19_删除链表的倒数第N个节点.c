//
//  Easy_19_删除链表的倒数第N个节点.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/27.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* removeNthFromEnd(struct ListNode* head, int n){
//    struct ListNode* tempNode = head;
//    int count = 0;
//    while (tempNode) {
//        tempNode = tempNode->next;
//        count++;
//    }
//    tempNode = head;
//    if (count == 1) {
//        return NULL;
//    }
//    if (count == n) {
//        return head->next;
//    }
//    count = count-n;
//    while (count > 1) {
//        tempNode = tempNode->next;
//        count--;
//    }
//    if (tempNode->next->next) {
//        tempNode->next = tempNode->next->next;
//    } else {
//        tempNode->next = NULL;
//    }
//
//    return head;
    
    // 设置一个哑巴节点，保证 dummy->next 是存在的，避免删头结点需要判断的问题
    struct ListNode* dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* tempNode = head;
    int count = 0;
    while (tempNode) {
        tempNode = tempNode->next;
        count++;
    }
    count = count-n;
    tempNode = dummy;
    while (count > 0) {
        tempNode = tempNode->next;
        count--;
    }
    tempNode->next = tempNode->next->next;

    return dummy->next;
}

struct ListNode* removeNthFromEnd2(struct ListNode* head, int n){
    struct ListNode* dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode* fastNode = dummy->next;
    struct ListNode* slowNode = dummy;
    for (int i = 0; i < n; i++) {
        fastNode = fastNode->next;
    }
    while (fastNode) {
        fastNode = fastNode->next;
        slowNode = slowNode->next;
    }
    slowNode->next = slowNode->next->next;
    return dummy->next;
}
