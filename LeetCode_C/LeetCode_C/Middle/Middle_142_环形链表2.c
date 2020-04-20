//
//  Middle_142_环形链表2.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/4/1.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
struct ListNode {
    int val;
    struct ListNode *next;
};

// 先找相遇点 再找循环入口
struct ListNode *detectCycle(struct ListNode *head) {
    struct ListNode *low = head;
    struct ListNode *fast = head;
    
    struct ListNode *meet = NULL;
    while (fast != NULL && fast->next != NULL) {
        fast = fast->next->next;
        low = low->next;
        if (fast == low) {
            meet = low;
            break;
        }
    }
    
    if (meet != NULL) {
        low = head;
        while (meet != low) {
            low = low->next;
            meet = meet->next;
        }
        return meet;
    }
    return NULL;
}
