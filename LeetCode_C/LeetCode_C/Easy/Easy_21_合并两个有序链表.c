//
//  Easy_21_合并两个有序链表.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/31.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* mergeTwoLists(struct ListNode* l1, struct ListNode* l2){
    struct ListNode *dummy = (struct ListNode *)malloc(sizeof(struct ListNode));
    dummy->next = l1;
    struct ListNode *node = dummy;
    while (l1 && l2) {
        if (l1->val > l2->val) {
            node->next = l2;
            l2 = l2->next;
        } else {
            node->next = l1;
            l1 = l1->next;
        }
        node = node->next;
        node->next = NULL;
    }
    if (l1) {
        node->next = l1;
    }
    if (l2) {
        node->next = l2;
    }
    
    return dummy->next;
}

// 递归
struct ListNode* mergeTwoLists1(struct ListNode* l1, struct ListNode* l2){
    if (l1 == NULL) {
        return l2;
    } else if (l2 == NULL) {
        return l1;
    } else {
        if (l1->val < l2->val) {
            l1->next = mergeTwoLists1(l1->next, l2);
            return l1;
        } else {
            l2->next = mergeTwoLists1(l1, l2->next);
            return l2;
        }
    }
}
