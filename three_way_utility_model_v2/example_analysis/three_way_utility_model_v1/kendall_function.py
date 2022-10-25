from scipy.stats import kendalltau
import numpy as np
import pandas as pd


def sckendall(X, Y):
    '''
    输入的时候注意，假设X为参照，X为有序,Y为无序
    '''
    L = len(X)
    X1 = pd.Series(X)
    Y1 = pd.Series(Y)
    X_index = X1.sort_values().index
    Y_index = Y1.sort_values().index
    # print(X_index)
    # print(Y_index)
    count = 0
    for i in range(L - 1):
        for j in range(i + 1, L):
            count = count + np.sign(X_index[i] - X_index[j]) * np.sign(Y_index[i] - Y_index[j])
    # print(count)
    kendall_tau = count / (L * (L - 1) / 2)

    return kendall_tau


def spearman_correlation_cofficient_function(X, Y):
    X_index = pd.Series(X).sort_values().index
    Y_index = pd.Series(Y).sort_values().index
    kendall_tau, p_value = kendalltau(X_index, Y_index)

    return kendall_tau


if __name__ == '__main__':
    # X = [6, 8, 3, 1, 5, 7, 4, 2]
    # Y = [6, 8, 3, 7, 1, 4, 5, 2]
    # X = [8, 2, 7, 3, 6, 4, 1, 5]
    # Y = [3, 2, 5, 6, 7, 4, 1, 8]
    # X = [1, 2, 3, 4, 5, 6, 7, 8]
    # Y = [1, 2, 6, 4, 8, 7, 5, 3]
    X = [7, 2, 4, 6, 8, 5, 3, 1]
    Y = [7, 2, 1, 6, 3, 4, 5, 8]

    # 调用库函数的时候要采用索引
    X_index = pd.Series(X).sort_values().index
    Y_index = pd.Series(Y).sort_values().index
    kendall_tau_2, p_value = kendalltau(X_index, Y_index)
    print('调用库函数：', kendall_tau_2)

    # 非调用库函数
    kendall_tau = sckendall(X, Y)
    print('非调用库函数：', kendall_tau)

    # spearman_correlation_cofficient_function
    print(spearman_correlation_cofficient_function(X, Y))
