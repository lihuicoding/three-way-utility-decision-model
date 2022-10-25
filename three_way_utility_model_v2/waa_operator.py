"""
WAA算子
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

result = []
for i in range(n):
    result.append((i + 1, sum(S[i] * W)))
result = sorted(result, reverse=True, key=lambda e: e[1])
print(result)

waa_ranking_result_by_object_index = [1 for i in range(len(result) + 1)]
for i in range(len(result)):
    waa_ranking_result_by_object_index[result[i][0]] = i + 1

with open('waa_ranking_result.csv', 'a', newline='') as waa_ranking_result_file:
    writer_2 = csv.writer(waa_ranking_result_file)
    writer_2.writerow(waa_ranking_result_by_object_index[1:])
    waa_ranking_result_file.close()