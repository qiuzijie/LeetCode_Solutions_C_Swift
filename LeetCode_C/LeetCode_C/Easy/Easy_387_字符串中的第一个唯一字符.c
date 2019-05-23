//
//  Easy_387_字符串中的第一个唯一字符.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/13.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int firstUniqChar(char * s){
    size_t size = strlen(s);
    int array[26] = {0};
    for (int i = 0; i < size; i++) {
        int n = s[i] - 'a';
        array[n]++;
    }
    for (int i = 0; i < size; i++) {
        if (array[s[i]-'a'] == 1) {
            return i;
        }
    }
    return -1;
}

