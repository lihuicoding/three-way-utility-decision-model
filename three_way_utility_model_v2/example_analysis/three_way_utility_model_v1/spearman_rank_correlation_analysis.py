"""
斯皮尔曼相关系数计算
"""
import pandas as pd
import scipy.stats

M = [[7, 2, 6, 4, 1, 3, 5, 8],
     [7, 2, 6, 4, 1, 3, 5, 8],
     [7, 2, 6, 4, 1, 3, 5, 8],
     [7, 2, 4, 6, 8, 5, 3, 1],
     [7, 2, 6, 1, 4, 3, 5, 8],
     [7, 3, 2, 1, 4, 6, 8, 5],
     [7, 3, 5, 2, 1, 8, 4, 6],
     [7, 2, 1, 6, 4, 3, 5, 8],
     [7, 2, 1, 6, 3, 4, 5, 8]]
n = len(M)

result = [[0.0 for i in range(n)] for i in range(n)]

for i in range(n):
    X = pd.Series(M[i])
    for j in range(n):
        Y = pd.Series(M[j])
        result[i][j] = X.corr(Y, method='spearman')

for i in range(n):
    for j in range(n):
        print(format(result[i][j], '.4f'), end=" ")
    print("")

# print(scipy.stats.spearmanr(M[6], M[7])[0])
print(scipy.stats.kendalltau(M[3], M[8])[1])