//
//  Easy_326_3的幂.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/3/4.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>

// 不使用递归或循环
bool isPowerOfThree(int n){
    
    return true;
}



bool helper(double n) {
    if (n == 1) {
        return true;
    } else if (n < 1) {
        return false;
    }
    return helper(n / 3.0);
}

// 递归
bool isPowerOfThree2(int n){
    return helper(n);
}

// 递归
bool isPowerOfThree1(int n){
    if (n == 1) {
        return true;
    } else if (n == 0) {
        return false;
    } else if (n % 3 == 0) {
        return isPowerOfThree1(n/3);
    } else {
        return false;
    }
}

