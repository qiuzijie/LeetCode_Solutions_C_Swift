//
//  Easy_237_删除链表中的节点.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/27.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

// 只知被删节点时的删除操作。值替换为下一个节点并删除。
void deleteNode(struct ListNode* node) {
    node->val = node->next->val;
    if (node->next->next) {
        node->next = node->next->next;
    } else {
        node->next = NULL;
    }
}
