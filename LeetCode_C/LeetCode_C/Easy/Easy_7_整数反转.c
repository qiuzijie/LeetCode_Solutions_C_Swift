//
//  Easy_7_整数反转.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/10.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int reverse(int x){
    int64_t temp = 0;
    while (x) {
        int a = x%10;
        temp = temp*10 + a;
        x /= 10;
    }
    if(temp < -pow(2,31) || temp > pow(2,31)-1)
        return 0;
    else
        return (int)temp;
}
