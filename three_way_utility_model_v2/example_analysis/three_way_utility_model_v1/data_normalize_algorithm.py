"""
数据标准化算法（模糊化）
"""

# 读取原始数据
origin_data = []

with open("computer_hardware_data_set.txt", encoding="utf-8", mode='r') as f:
    line = f.readline()
    while line != '':
        row = line.split(" ")
        row = [int(i) for i in row]
        origin_data.append(row)
        line = f.readline()
    f.close()

print(origin_data)

# 效益成本向量
is_benefit = [0, 1, 1, 1, 1, 1]
max_min_value_of_column = origin_data[0].copy()
for i in range(len(origin_data)):
    for j in range(len(origin_data[i])):
        if is_benefit[j] == 1:  # 表示为效益准则,求列的最大值
            if origin_data[i][j] > max_min_value_of_column[j]:
                max_min_value_of_column[j] = origin_data[i][j]
        else:  # 成本准则，求列的最小值
            if origin_data[i][j] < max_min_value_of_column[j]:
                max_min_value_of_column[j] = origin_data[i][j]
print(max_min_value_of_column)

# 正规化
normalized_data = [[0.0 for j in range(len(origin_data[0]))] for i in range(len(origin_data))]
for i in range(len(origin_data)):
    for j in range(len(origin_data[i])):
        if is_benefit[j] == 1:  # 表示为效益准则
            normalized_data[i][j] = origin_data[i][j] / max_min_value_of_column[j]
        else:  # 成本准则
            normalized_data[i][j] = max_min_value_of_column[j] / origin_data[i][j]
print(normalized_data)

with open('normalized_data.txt', encoding='utf-8', mode='a') as f:
    for i in range(len(normalized_data)):
        for j in range(len(normalized_data[i])):
            normalized_data[i][j] = format(normalized_data[i][j], ".2f")
        print(" ".join(normalized_data[i]), file=f)
    f.close()
