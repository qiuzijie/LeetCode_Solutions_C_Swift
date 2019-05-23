//
//  Easy_14_最长公共前缀.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/23.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/**
 n 为字符串个数
 最坏的情况：n个长度为m的相同字符串
 **/

/// 水平扫描法
/// O(S) S是所有字符串中字符数量的总和。
/// 最坏的情况 S m*n
char * longestCommonPrefix(char ** strs, int strsSize){
    if (strsSize < 1) {
        return "";
    }
    char *prefix = strs[0];
    for (int i = 1; i < strsSize; i++) {
        char *str = strs[i];
        for (int j = 0; j < strlen(prefix); j++) {
            if (prefix[j] != str[j]) {
                if (j == 0) {
                    return "";
                }
                prefix[j] = '\0';
                break;
            }
        }
    }
    return prefix;
}

/// 各字符串同位置字符比较
/// O(S)
/// 最差：m*n  m为最短的字符串
char * longestCommonPrefix1(char ** strs, int strsSize){
    if (strsSize < 1) {
        return "";
    }
    char *first = strs[0];
    
    for (int i = 0; i < strlen(first); i++) {
        char c = first[i];
        for (int j = 1; j < strsSize; j++) {
            char *str = strs[j];
            if (strlen(str) <= i || c != str[i]) {
                first[i] = '\0';
                return first;
            }
        }
    }
    return "";
}
