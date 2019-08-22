//
//  Easy_141_环形链表.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/6/13.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

// 数组是否包含
bool hasCycle(struct ListNode *head) {
    struct ListNode *node = head;
    struct ListNode *arr[1000];
    int count = 0;
    while (node) {
        for (int i = 0; i < count; i++) {
            if (arr[i] == node) {
                return true;
            }
        }
        arr[count++] = node;
        node = node->next;
    }
    return false;
}

// 快慢指针
bool hasCycle1(struct ListNode *head) {
    if (head == NULL || head->next == NULL)  {
        return false;
    }
    struct ListNode *fast = head->next->next;
    struct ListNode *slow = head;
    while (fast && fast->next) {
        if (slow == fast) {
            return true;
        }
        slow = slow->next;
        fast = fast->next->next;
    }
    return false;
}
