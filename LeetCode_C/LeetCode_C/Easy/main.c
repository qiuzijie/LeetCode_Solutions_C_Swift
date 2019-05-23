//
//  main.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/4/16.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

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
    
    char *haystack = "mississippi";
    char *needle = "issip";
    int length = strlen(needle);
    int *maxMatchs = (int *)malloc(sizeof(int)*length);
    *maxMatchs = 0;
    int maxLength = 0;
    for (int i = 1; i < length; i++) {
        if (maxLength > 0 && needle[i] != needle[maxLength]) {
            maxLength = maxMatchs[maxLength - 1];
        }
        if (needle[i] == needle[maxLength]) {
            maxLength++;
        }
        maxMatchs[i] = maxLength;
    }
    
    int j = 0;
    for (int i = 0; i < strlen(haystack); i++) {
        while (j > 0 && haystack[i] != needle[j]) {
            j = maxMatchs[j - 1];
        }
        if (haystack[i] == needle[j]) {
            j++;
        }
        if (j == strlen(needle)) {
            return i-j+1;
        }
    }
    
    
    
    return 0;
}
