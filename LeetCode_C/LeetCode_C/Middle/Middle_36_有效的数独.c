//
//  Middle_36_有效的数独.c
//  LeetCode_C
//
//  Created by qiuzijie on 2019/5/7.
//  Copyright © 2019 qiuzijie. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// 暴力
bool isValidSudoku(char** board, int boardSize, int* boardColSize){
    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < *boardColSize; j++) {
            char c = board[i][j];
            if (c != '.') {
                for (int k = i+1; k < boardSize; k++) {
                    if (board[k][j] == c) {
                        return false;
                    }
                }
                for (int k = j+1; k < *boardColSize; k++) {
                    if (board[i][k] == c) {
                        return false;
                    }
                }
                int row = i%3;
                int col = j%3;
                int oldi = i;
                for ( ; row<2; row++) {
                    oldi ++;
                    for (int k = 0; k < 3; k++) {
                        if (board[oldi][j+k-col] == c) {
                            return false;
                        }
                    }
                }
            }
        }
    }
    return true;
}

