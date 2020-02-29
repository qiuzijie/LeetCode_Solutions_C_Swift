//
//  Easy_278_第一个错误版本.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/26.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>

bool isBadVersion(int version);

int firstBadVersion(int n) {
    double left = 1, right = n;
    int middle = 0;
    int index = 1;
    while (left <= right) {
        middle = (int)((left + right)/2);
        if (isBadVersion(middle)) {
            right = middle-1;
            index = middle;
        } else {
            left = middle+1;
        }
    }
    return index;
}
