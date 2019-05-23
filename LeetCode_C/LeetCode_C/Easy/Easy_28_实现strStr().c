//
//  Easy_28_实现strStr().c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// 暴力
int strStr(char * haystack, char * needle){
    if (strlen(needle) == 0) {
        return 0;
    }
    for (int i = 0; i < strlen(haystack); i++) {
        if (strlen(haystack) - i < strlen(needle)) {
            return -1;
        }
        if (haystack[i] == needle[0]) {
            int temp = i;
            int j = 0;
            while (haystack[temp] && needle[j] && haystack[temp] == needle[j]) {
                temp++;
                j++;
            }
            if (needle[j] == '\0') {
                return i;
            }
        }
    }
    return -1;
}

// KMP 算法
int strStr1(char * haystack, char * needle){
    if (strlen(needle) == 0) {
        return 0;
    }
    if (strlen(haystack) < strlen(needle)) {
        return -1;
    }
    
    int length = strlen(needle);
    int *maxMatchs = (int *)malloc(sizeof(int)*length);
    *maxMatchs = 0;
    int maxLength = 0;
    for (int i = 1; i < length; i++) {
        if (maxLength > 0 && needle[i] != needle[maxLength]) {
            maxLength = maxMatchs[maxLength - 1];
        }
        if (needle[i] == needle[maxLength]) {
            maxLength++;
        }
        maxMatchs[i] = maxLength;
    }
    
    int j = 0;
    for (int i = 0; i < strlen(haystack); i++) {
        while (j > 0 && haystack[i] != needle[j]) {
            j = maxMatchs[j - 1];
        }
        if (haystack[i] == needle[j]) {
            j++;
        }
        if (j == strlen(needle)) {
            return i-j+1;
        }
    }
    
    return -1;
}
