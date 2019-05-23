//
//  Easy_125_验证回文串.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/15.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

bool isPalindrome(char * s){
    int low = 0;
    int high = strlen(s)-1;
    
    while (low <= high) {
        if (s[low] <= 'Z' && s[low] >= 'A') {
            s[low] = s[low] + 32;
        }
        if (s[high] <= 'Z' && s[high] >= 'A') {
            s[high] = s[high] + 32;
        }
        if (!(s[low] <= 'z' && s[low] >= 'a') && !(s[low] >= '0' && s[low] <= '9')) {
            low++;
            continue;
        }
        if (!(s[high] <= 'z' && s[high] >= 'a') && !(s[high] >= '0' && s[high] <= '9')) {
            high--;
            continue;
        }
        if (s[low++] != s[high--]) {
            return false;
        }
    }
    
    return true;
}
