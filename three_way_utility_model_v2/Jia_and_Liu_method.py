"""
JiaFan和LiuPeiDe相对损失函数方法
"""

import numpy as np
import csv

# 读取数据，构造信息矩阵S
S = []
with open('normalized_data.csv') as f:
    csv_reader = csv.reader(f)
    for row in csv_reader:
        row = [float(i) for i in row]
        S.append(row)
    f.close()
n = len(S)  # 对象的个数
m = len(S[0])  # 准则的个数
S = np.array(S)

# 权重向量W
W = [1/m for i in range(m)]
W = np.array(W)

# 损失函数前的系数
theta = np.array([0.3 for i in range(m)])

# 准则中的最大最小标准
max_value = np.array([1 for i in range(m)])
min_value = np.array([0 for i in range(m)])

result_1 = []
result_2 = []
result_3 = []
for i in range(n):
    result_1.append(sum(W * (1 - theta) * (max_value - S[i])) / (
            sum(W * (1 - theta) * (max_value - S[i])) + sum(W * theta * (S[i] - min_value))))
    result_2.append(sum(W * theta * (max_value - S[i])) / (
            sum(W * theta * (max_value - S[i])) + sum(W * (1 - theta) * (S[i] - min_value))))
    result_3.append(sum(W * (max_value - S[i])) / sum(W * (max_value - min_value)))

rank_1 = []
rank_2 = []
rank_3 = []
for i in range(len(result_1)):
    rank_1.append((i + 1, result_1[i]))
    rank_2.append((i + 1, result_2[i]))
    rank_3.append((i + 1, result_3[i]))
rank_1 = sorted(rank_1, reverse=False, key=lambda e: e[1])
rank_2 = sorted(rank_2, reverse=False, key=lambda e: e[1])
rank_3 = sorted(rank_3, reverse=False, key=lambda e: e[1])
print(rank_1)
print(rank_2)
print(rank_3)

# 7 2 6 4 1 3 5 8

jia_and_liu_ranking_result_by_object_index = [1 for i in range(len(rank_1) + 1)]
for i in range(len(rank_1)):
    jia_and_liu_ranking_result_by_object_index[rank_1[i][0]] = i + 1

with open('jia_and_liu_ranking_result.csv', 'a', newline='') as jia_and_liu_ranking_result_file:
    writer_2 = csv.writer(jia_and_liu_ranking_result_file)
    writer_2.writerow(jia_and_liu_ranking_result_by_object_index[1:])
    jia_and_liu_ranking_result_file.close()
