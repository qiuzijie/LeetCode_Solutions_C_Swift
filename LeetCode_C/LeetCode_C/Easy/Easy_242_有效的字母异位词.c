//
//  Easy_242_有效的字母异位词.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/14.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool isAnagram(char * s, char * t){
    int arrayS[26] = {0};
    int arrayT[26] = {0};
    
    if (strlen(s) != strlen(t)) {
        return false;
    }
    for (int i = 0; i < strlen(s); i++) {
        char c = s[i];
        arrayS[c-'a'] = arrayS[c-'a'] + 1;
        c = t[i];
        arrayT[c-'a'] = arrayT[c-'a'] + 1;
    }
    for (int i = 0; i < 26; i++) {
        if (arrayS[i] != arrayT[i]) {
            return false;
        }
    }
    
    return true;
}

bool isAnagram1(char *s, char *t){
    int i, x[26] = {0};
    while (*s) {
        x[*s++ - 'a']++;
    }
    while (*t) {
        x[*t++ - 'a']--;
    }
    for (i = 0; i<26; i++) {
        if (x[i]) {// 除了0 都是true
            return false;
        }
    }
    return true;
}
