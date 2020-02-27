//
//  Easy_70_爬楼梯.c
//  LeetCode_C
//
//  Created by qiuzijie on 2020/2/27.
//  Copyright © 2020 qiuzijie. All rights reserved.
//

#include <stdio.h>

/// 动态规划 爬n阶的方法数量等于爬n-1、n-2阶楼梯方法数量之和
int climbStairs(int n){
    int array[n];
    
    for (int i = 1; i <= n; i++) {
        if (i == 1) {
            array[1] = 1;
        } else if (i == 2) {
            array[2] = 2;
        } else {
            array[i] = array[i-1] + array[i-1];
        }
    }
    return array[n];
}

/// 暴力 O(2^n)
int climb(int i, int n) {
    if (i > n) {
        return 0;
    }
    if (i == n) {
        return 1;
    }
    return climb(i+1, n)+climb(i+2, n);
}

int climbStairs1(int n){
    return climb(0, n);
}

/// 修复暴力 O(n)
int climb2(int i, int n, int* memory) {
    if (i > n) {
        return 0;
    }
    if (i == n) {
        return 1;
    }
    if (memory[i] > 0) {
        return memory[i];
    }
    memory[i] = climb2(i+1, n, memory)+climb2(i+2, n, memory);
    return memory[i];
}

int climbStairs2(int n){
    int memory[n+1];
    for (int i = 0; i < n; i++) {
        memory[i] = 0;
    }
    return climb2(0, n, memory);
}
