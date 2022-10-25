"""
WAA算子
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

result = []
for i in range(n):
    result.append((i + 1, sum(S[i] * W)))
result = sorted(result, reverse=True, key=lambda e: e[1])
print(result)
