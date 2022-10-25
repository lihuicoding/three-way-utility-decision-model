'''
spearman correlation coefficient function
'''

import pandas as pd


def spearman_correlation_cofficient_function(X, Y):
    # 原始数据序列化
    X1 = pd.Series(X)
    Y1 = pd.Series(Y)
    n = X1.count()
    # 计算秩序差
    d = (X1.sort_values().index - Y1.sort_values().index) ** 2
    dd = d.to_series().sum()
    # print(X1.sort_values().index)
    # print(Y1.sort_values().index)
    # 计算相关系数
    p = 1 - 6 * dd / (n * (n ** 2 - 1))

    return p


if __name__ == '__main__':
    X = [7, 2, 4, 6, 8, 5, 3, 1]
    Y = [7, 2, 1, 6, 3, 4, 5, 8]
    # X = [10, 5, 1, 2, 8, 6, 9, 4, 7, 3]
    # Y = [10, 4, 1, 2, 9, 5, 7, 8, 6, 3]
    result = spearman_correlation_cofficient_function(X, Y)
    # print(pd.Series(X).corr(pd.Series(Y), method='spearman'))
    print(result)
    X = [6, 8, 3, 1, 5, 7, 4, 2]
    Y = [6, 8, 3, 7, 1, 4, 5, 2]
    print(pd.Series(pd.Series(X).sort_values().index).corr(pd.Series(pd.Series(Y).sort_values().index),
                                                           method='spearman'))
    print(pd.Series(X).corr(pd.Series(Y), method='kendall'))
    print(spearman_correlation_cofficient_function(X, Y))
