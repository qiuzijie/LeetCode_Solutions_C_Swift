//
//  Easy_344_反转字符串.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/10.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

void reverseString(char* s, int sSize){
    if (sSize < 2) {
        return;
    }
    for (int i = 0; i < sSize/2; i++) {
        char temp = s[i];
        s[i] = s[sSize-i-1];
        s[sSize-i-1] = temp;
        
        /** 
            s[i] = s[i]^s[sSize-i-1];
            s[sSize-i-1] = s[i]^s[sSize-i-1];
            s[i] = s[i]^s[sSize-i-1];
        **/
    }
}


