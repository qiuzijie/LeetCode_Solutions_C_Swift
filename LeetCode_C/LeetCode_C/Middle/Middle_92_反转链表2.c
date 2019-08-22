//
//  Middle_92_反转链表2.c
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

// 蠢办法
struct ListNode* reverseBetween(struct ListNode* head, int m, int n){
    struct ListNode *newHead = head;
    struct ListNode *link1 = NULL;
    struct ListNode *link2 = NULL;
    struct ListNode *link3 = NULL;
    int temp = 1;
    while (head != NULL) {
        if (temp >= m && temp <= n) {
            struct ListNode *node = (struct ListNode *)malloc(sizeof(struct ListNode ));
            node->val = head->val;
            node->next = link2;
            link2 = node;
            if (temp == m) {
                link3 = node;
            }
        } else if (temp < m) {
            link1 = head;
        } else if (temp == n + 1) {
            link3->next = head;
        } else {
            break;
        }
        head = head->next;
        temp++;
    }
    if (link1) {
        link1->next = link2;
    } else {
        newHead = link2;
    }
    
    return newHead;
}

struct ListNode* reverseBetween1(struct ListNode* head, int m, int n){
    struct ListNode *dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = head;
    struct ListNode *pre = dummy;
    for (int i = 1; i < m; i++) {
        pre = pre->next;
    }
    struct ListNode *cur = pre->next;
    for (int i = m; i < n; i++) {
        struct ListNode *temp = cur->next;
        cur->next = temp->next;
        temp->next = pre->next;
        pre->next = temp;
    }
    return dummy->next;
}
