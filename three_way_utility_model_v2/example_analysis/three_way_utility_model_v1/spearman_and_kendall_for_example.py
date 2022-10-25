'''
案例分析的spearman相关系数和kendall相关系数计算
'''

from page_1_algorithm.three_way_utility_model_v1 import spearman_function, kendall_function
import numpy as np


# 列表输出格式化
def print_format(M):
    dim = np.array(M).shape
    for i in range(dim[0]):
        for j in range(dim[1]):
            print(format(M[i][j], '.4f'), end=" ")
        print("")


if __name__ == '__main__':
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

    print("Spearman相关系数：")
    # 计算斯皮尔秩相关系数
    spearman_result = []
    for i in range(n):
        row = []
        for j in range(n):
            row.append(spearman_function.spearman_correlation_cofficient_function(M[i], M[j]))
        spearman_result.append(row)
    print_format(spearman_result)

    print("Kendall相关系数：")
    # 计算肯德尔秩相关系数
    kendall_result = []
    for i in range(n):
        row = []
        for j in range(n):
            row.append(kendall_function.sckendall(M[i], M[j]))
        kendall_result.append(row)
    print_format(kendall_result)

    # print("Kendall相关系数：")
    # # 计算肯德尔秩相关系数
    # kendall_result = []
    # for i in range(n):
    #     row = []
    #     for j in range(n):
    #         row.append(kendall_function.spearman_correlation_cofficient_function(M[i], M[j]))
    #     kendall_result.append(row)
    # print_format(kendall_result)
