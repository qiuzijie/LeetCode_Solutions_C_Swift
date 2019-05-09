//
//  main.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

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


int compare (const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int main(int argc, const char * argv[]) {
    // insert code here...
    int nums[] = {397,6621,4997,7506,8918,1662,9187,3278,3890,514,18,9305,93,5508,3031,2692,6019,1134,1691,4949,5071,799,8953,
        397,6621,4997,7506,8918,1662,9187,3278,3890,514,18,9305,93,5508,3031,2692,6019,1134,1691,4949,5071,799,8953
    };
    qsort(nums, 46, sizeof(int), compare);
    return 0;
}
