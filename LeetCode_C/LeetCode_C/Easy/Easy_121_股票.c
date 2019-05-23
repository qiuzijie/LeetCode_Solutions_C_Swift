//
//  Easy_121.c
//  C_Leecode_Test
//
//  Created by qiuzijie on 2019/4/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>

//暴力
//O(n²) O(1)
int maxProfit1(int* prices, int pricesSize) {
    int max = 0;
    for (int i = 0; i < pricesSize-1; i++) {
        for (int j = i+1; j < pricesSize; j++) {
            int total = prices[j] - prices[i];
            if (total > max) {
                max = total;
            }
        }
    }
    if (max<0) {
        return 0;
    }
    return max;
}

//遍历每一个价格时减去目前的波谷，保存最大利润
//O(n) O(1)
int maxProfit2(int* prices, int pricesSize) {
    if (pricesSize == 0) {
        return 0;
    }
    int min = prices[0];
    int maxProfit = 0;
    for (int i = 1; i < pricesSize; i++) {
        if (prices[i] < min) {
            min = prices[0];
        } else if (prices[i] - min > maxProfit) {
            maxProfit = prices[i] - min;
        }
        
    }
    return maxProfit;
}
