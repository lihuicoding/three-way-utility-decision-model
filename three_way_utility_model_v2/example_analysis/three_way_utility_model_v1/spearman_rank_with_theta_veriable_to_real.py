'''
theta变化产生的排序结果与实际性能排序的Spearman相关系数
'''

from page_1_algorithm.three_way_utility_model_v1 import spearman_function, kendall_function

M = [[7, 2, 6, 4, 3, 5, 8, 1],  # theta=0.55
     [7, 2, 6, 4, 3, 5, 8, 1],
     [7, 2, 1, 6, 4, 3, 5, 8],
     [7, 2, 1, 6, 4, 3, 5, 8],
     [7, 2, 1, 6, 4, 3, 5, 8],
     [7, 2, 1, 6, 4, 3, 5, 8],
     [7, 2, 1, 6, 8, 4, 3, 5],
     [7, 2, 1, 6, 8, 4, 3, 5],
     [7, 2, 1, 6, 8, 4, 3, 5],
     [7, 2, 1, 6, 8, 4, 3, 5]]  # theta=1.00

real = [7, 2, 1, 6, 3, 4, 5, 8]  # 实际性能排序
s_result = []
k_result = []

for i in range(len(M)):
    s_result.append(float(format(spearman_function.spearman_correlation_cofficient_function(M[i], real), '.4f')))
    k_result.append(float(format(kendall_function.spearman_correlation_cofficient_function(M[i], real), '.4f')))

print(s_result)
print(k_result)
