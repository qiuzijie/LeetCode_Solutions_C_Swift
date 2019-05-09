//
//  Middle_48_旋转图像.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/8.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>


/**
 旋转方式
 123  361  361  741
 456  452  852  852
 789  789  947  963
 **/
void rotateOnce(int** matrix, int size, int top){// 4  1
    int bottom = size-top-1;// 2
    int left = top;// 1
    int right = bottom; // 2
    
    //上右互换
    for (int i=left; i<right; i++) {
        int temp = matrix[top][i];
        matrix[top][i] = matrix[i][right];
        matrix[i][right] = temp;
    }
    
    // 下左互换
    for (int i=right; i>left; i--) {
        int temp = matrix[bottom][i];
        matrix[bottom][i] = matrix[i][left];
        matrix[i][left] = temp;
    }
    
    // 上下互换
    for (int i=0; i<right-left; i++) {
        int temp = matrix[top][left+i];
        matrix[top][left+i] = matrix[bottom][right-i];
        matrix[bottom][right-i] = temp;
    }
}

void rotate(int** matrix, int matrixSize, int* matrixColSize){
    int count = matrixSize/2;
    for (int i = 0; i < count; i++) {
        rotateOnce(matrix, matrixSize, i);
    }
}
