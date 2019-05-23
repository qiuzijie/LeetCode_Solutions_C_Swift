//
//  Easy_122.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

int calculateMax(int *prices, int pricesSize, int start) {
    if (start >= pricesSize) {
        return 0;
    }
    int maxProfit = 0;
    for (int i = start; i < pricesSize; i++) {
        int max = 0;
        for (int j = i+1; j < pricesSize; j++) {
            if (prices[i] < prices[j]) {
                int profit = prices[j] - prices[i] + calculateMax(prices, pricesSize, j+1);
                if (profit > max) {
                    max = profit;
                }
            } else {
                break;
            }
        }
        if (max > maxProfit) {
            maxProfit = max;
        }
    }
    return maxProfit;
}

// 暴力 递归算出每一次利润
// 复杂度 ：
int maxProfit1(int* prices, int pricesSize) {
    return calculateMax(prices, pricesSize, 0);
}


/**
 绘曲线图有利于看出最大利润等于啥
 **/

// 峰谷法 找到峰谷对应的峰顶
// 复杂度 O(n) O(1)
int maxProfit2(int* prices, int pricesSize) {
    if (pricesSize < 2) {
        return 0;
    }
    int min = prices[0];
    int oldMax = 0;
    int profit = 0;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] <= min) {
            if (oldMax > min) {
                profit += oldMax - min;
                oldMax = 0;
            }
            min = prices[i];
        } else {
            if (prices[i] < oldMax) {
                profit += oldMax - min;
                min = prices[i];
                oldMax = 0;
            } else {
                oldMax = prices[i];
            }
        }
    }
    if (oldMax > min) {
        profit += oldMax - min;
    }
    return profit;
}

// 只关注差额 最大利润就等于每一段上升线段之和
// 复杂度 O(n) O(1)
int maxProfit3(int *prices, int priceSize) {
    if (priceSize < 2) {
        return 0;
    }
    int profit = 0;
    for (int i = 1; i < priceSize; i++) {
        if (prices[i] > prices[i-1]) {
            profit += prices[i-1] - prices[i];
        }
    }
    
    return profit;
}
