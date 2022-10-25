"""
TOPSIS方法
"""

import numpy as np
import csv

# 读取数据，构造信息矩阵S
S = []
# with open("normalized_data.txt", encoding="utf-8") as f:
#     line = f.readline()
#     while line != '':
#         row = line.split(" ")
#         row = [float(i) for i in row]
#         S.append(row)
#         line = f.readline()
#     f.close()
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
# concrete data set
# W = [0.3, 0.05, 0.05, 0.1, 0.1, 0.1, 0.1, 0.2]
# CSM data set
# W = [0.3, 0.1, 0.1, 0.1, 0.1, 0.2, 0.05, 0.05]
W = [1 / m for i in range(m)]
W = np.array(W)

# 权重归一化
for i in range(n):
    S[i] = S[i] * W
# print(S)

# 计算正理想解，每列最大值
positive_solution = np.max(S, 0)
# 计算负理想解，每列最小值
negative_solution = np.min(S, 0)

# 求到正理想和负理想解的距离
positive_S = S.copy()
negative_S = S.copy()
for i in range(n):
    positive_S[i] = positive_solution - S[i]
    negative_S[i] = S[i] - negative_solution
# print(positive_S)
# print(negative_S)
positive_distance = np.sqrt(np.sum(positive_S * positive_S, 1))
negative_distance = np.sqrt(np.sum(negative_S * negative_S, 1))
result = negative_distance / (positive_distance + negative_distance)
rank = []
for i in range(len(result)):
    rank.append((i + 1, result[i]))
rank = sorted(rank, reverse=True, key=lambda e: e[1])
print(rank)

topsis_ranking_result_by_object_index = [1 for i in range(len(rank) + 1)]
for i in range(len(rank)):
    topsis_ranking_result_by_object_index[rank[i][0]] = i + 1

with open('topsis_ranking_result.csv', 'a', newline='') as topsis_ranking_result_file:
    writer_2 = csv.writer(topsis_ranking_result_file)
    writer_2.writerow(topsis_ranking_result_by_object_index[1:])

    topsis_ranking_result_file.close()

# 7 2 6 4 1 3 5 8