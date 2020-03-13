//
//  Easy_204_计数质数.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/3/4.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

// 暴力超时
int countPrimes(int n){
    int sum = 0;

    for (int i = 2; i < n; i++) {
        bool flag = true;
        for (int j = 2; j < i; j++) {
            if (i % j == 0) {
                flag = false;
                break;
            }
        }
        if (flag) {
            sum++;
        }
    }
    return sum;
}

// 对正整数n，如果用2到 根号n 之间的所有整数去除，均无法整除，则n为质数。
int countPrimes1(int n){
    int sum = 0;

    for (int i = 2; i < n; i++) {
        bool flag = true;
        for (int j = 2; j <= sqrt(i); j++) {
            if (i % j == 0) {
                flag = false;
                break;
            }
        }
        if (flag) {
            sum++;
        }
    }
    return sum;
}
