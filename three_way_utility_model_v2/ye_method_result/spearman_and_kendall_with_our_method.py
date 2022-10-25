'''
随着theta的变化，数据集的排序结果与真实结果的Spearman相关系数
'''
import pandas as pd
import csv
import xlrd
import math

# 创建一个空列表，存储数据
table = []
real = []
# 读取排序结果数据
with open('..\\our_model_result\\winequality_white_ranking_result.csv') as f:
    read_csv = csv.reader(f)
    for row in read_csv:
        table.append(row)
    f.close()
# print(table)

# 读取比较方法排序数据
with open('winequality_white_ye_ranking_result.csv') as f:
    read_csv = csv.reader(f)
    for row in read_csv:
        real.append([int(i) for i in row])
    f.close()

ranking_result_by_object_index = [1 for i in range(len(real[0]) + 1)]
for i in range(len(real[0])):
    ranking_result_by_object_index[real[0][i]] = i + 1
real[0] = ranking_result_by_object_index[1:]

# data = xlrd.open_workbook('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\Concrete_Data.xls')
# sheet = data.sheets()[0]
# for i in range(1, sheet.nrows):
#     value = sheet.row_values(i)[8]
#     real.append((i, value))
#
# # 实际性能排序
# real_rank = sorted(real, reverse=True, key=lambda r: r[1])
# real_ranking_result_by_object_index = [1 for i in range(len(real_rank) + 1)]
# for i in range(len(real_rank)):
#     real_ranking_result_by_object_index[real_rank[i][0]] = i + 1
# real = real_ranking_result_by_object_index[1:]


# 计算
# 在进行计算的时候不需要索引，因为读取出来的数据已经是索引了
with open('spearman_and_kendall_rusult.csv', 'a', newline='') as f:
    write_csv = csv.writer(f)
    for i in range(len(table)):
        # print(real)
        s = math.fabs(float(format(pd.Series(table[i][1:]).corr(pd.Series(real[0]), method='spearman'), '.4f')))
        k = math.fabs(float(format(pd.Series(table[i][1:]).corr(pd.Series(real[0]), method='kendall'), '.4f')))
        theta = float(format(float(table[i][0]), '.4f'))
        write_csv.writerow([theta, s, k])  # theta, spearman, kendall
    f.close()
