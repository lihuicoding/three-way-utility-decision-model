"""
JiaFan和LiuPeiDe相对损失函数方法
"""

import numpy as np

# 读取数据，构造信息矩阵S
S = []
with open("normalized_data.txt", encoding="utf-8") as f:
    line = f.readline()
    while line != '':
        row = line.split(" ")
        row = [float(i) for i in row]
        S.append(row)
        line = f.readline()
    f.close()
n = len(S)  # 对象的个数
m = len(S[0])  # 准则的个数
S = np.array(S)

# 权重向量W
W = [0.20, 0.25, 0.30, 0.14, 0.03, 0.08]
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