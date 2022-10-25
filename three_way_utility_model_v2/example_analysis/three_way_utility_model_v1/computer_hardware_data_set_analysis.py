import xlrd
import xlwt

# 读取Excel数据
# 导入需要读取的第一个Excel表格的路径
data = xlrd.open_workbook(r'D:\湖南师范大学本科毕业设计\数据\machine.xlsx')
table_1 = data.sheets()[0]
# 创建一个空列表，存储Excel数据
table = []


# 将excel表格内容导入到tables列表中
def import_excel(excel):
    for row in range(1, excel.nrows):
        arr = excel.row_values(row)[:6]
        table.append(arr)


import_excel(table_1)

# 向Excel中写入数据
book = xlwt.Workbook(encoding='utf-8')
sheet1 = book.add_sheet(u'Sheet1', cell_overwrite_ok=True)
sheet2 = book.add_sheet(u'Sheet2', cell_overwrite_ok=True)
sheet3 = book.add_sheet(u'Sheet3', cell_overwrite_ok=True)


# 向单元格添加数据
def write_file(sheet, r, c, value):
    sheet.write(r, c, value)


# 数据正规化
# 效益成本向量
is_benefit = [0, 1, 1, 1, 1, 1]
max_min_value_of_column = table[0].copy()
for i in range(len(table)):
    for j in range(len(table[i])):
        if is_benefit[j] == 1:  # 表示为效益准则,求列的最大值
            if table[i][j] > max_min_value_of_column[j]:
                max_min_value_of_column[j] = table[i][j]
        else:  # 成本准则，求列的最小值
            if table[i][j] < max_min_value_of_column[j]:
                max_min_value_of_column[j] = table[i][j]
# print(max_min_value_of_column)

# 正规化
normalized_data = [[0.0 for j in range(len(table[0]))] for i in range(len(table))]
for i in range(len(table)):
    for j in range(len(table[i])):
        if is_benefit[j] == 1:  # 表示为效益准则
            normalized_data[i][j] = table[i][j] / max_min_value_of_column[j]
        else:  # 成本准则
            normalized_data[i][j] = max_min_value_of_column[j] / table[i][j]
print(normalized_data)


# 权重向量W
W = [0.20, 0.25, 0.30, 0.14, 0.03, 0.08]

n = len(normalized_data)  # 对象的个数
m = len(normalized_data[0])  # 准则的个数

# 最小要求L
min_requirement = [110, 1000, 6000, 64, 8, 24]  # 参考原始数据
L = [0.23, 0.06, 0.19, 0.25, 0.50, 0.19]
for i in range(len(min_requirement)):
    if is_benefit[i] == 1:  # 表示为效益准则
        L[i] = min_requirement[i] / max_min_value_of_column[i]
    else:  # 成本准则
        L[i] = max_min_value_of_column[i] / min_requirement[i]
print(L)
# 计算条件概率
P = [0.0 for i in range(n)]
for i in range(n):
    s = 0
    for j in range(m):
        if normalized_data[i][j] >= L[j]:
            s += W[j]
    P[i] = s
# print(P)

# 效用偏向因子theta
theta = 0.50
r = 0  # 写入行数

while theta < 1.00:
    theta += 0.01
    if theta >= 1.00:
        theta = 1.00
    print(theta)
    # 计算效用函数
    PP = [0.0 for i in range(n)]
    BP = [0.0 for i in range(n)]
    BN = [0.0 for i in range(n)]
    NN = [0.0 for i in range(n)]
    for i in range(n):
        sum_1 = 0
        sum_2 = 0
        for j in range(m):
            sum_1 += W[j] * normalized_data[i][j] / (1 + L[j])
            sum_2 += W[j] * ((1 - normalized_data[i][j]) / (1 + L[j]))
        PP[i] = sum_1
        BP[i] = sum_1 * theta
        NN[i] = sum_2
        BN[i] = sum_2 * theta
    # print("PP：", PP)
    # print("BP：", BP)
    # print("BN：", BN)
    # print("NN：", NN)

    # 计算阈值
    alpha = [0.0 for i in range(n)]
    beta = [0.0 for i in range(n)]
    gamma = [0.0 for i in range(n)]
    for i in range(n):
        alpha[i] = BN[i] / (PP[i] - BP[i] + BN[i])
        beta[i] = (NN[i] - BN[i]) / (BP[i] + NN[i] - BN[i])
        gamma[i] = NN[i] / (PP[i] + NN[i])
    # print("alpha：", alpha)
    # print("beta：", beta)
    # print("gamma：", gamma)

    # 进行三支聚类
    POS = []
    BND = []
    NEG = []
    EU = [0.0 for i in range(n)]
    for i in range(n):
        if P[i] >= alpha[i]:
            POS.append((i + 1, PP[i] * P[i]))
        elif P[i] <= beta[i]:
            NEG.append((i + 1, (1 - P[i]) * NN[i]))
        else:
            BND.append((i + 1, BP[i] * P[i] + BN[i] * (1 - P[i])))

    # 排序
    POS = sorted(POS, reverse=True, key=lambda pos: pos[1])
    BND = sorted(BND, reverse=True, key=lambda bnd: bnd[1])
    NEG = sorted(NEG, reverse=True, key=lambda neg: neg[1])
    ranking_result = [pos[0] for pos in POS] + [bnd[0] for bnd in BND] + [neg[0] for neg in NEG]
    ranking_result_by_object_index = [1 for i in range(len(ranking_result) + 1)]
    for i in range(len(ranking_result)):
        ranking_result_by_object_index[ranking_result[i]] = i + 1

    # print(POS)
    # print(BND)
    # print(NEG)
    # print("正域对象个数：", len(POS))
    # print("边界域对象个数：", len(BND))
    # print("负域对象个数：", len(NEG))
    # print(ranking_result)

    write_file(sheet1, r, 0, theta)
    write_file(sheet1, r, 1, len(POS))
    write_file(sheet1, r, 2, len(BND))
    write_file(sheet1, r, 3, len(NEG))

    write_file(sheet2, r, 0, theta)
    for i in range(len(ranking_result)):
        write_file(sheet2, r, i + 1, ranking_result_by_object_index[i + 1])

    r += 1

# 实际性能排序
real_rank = []
for row in range(1, table_1.nrows):
    arr = table_1.row_values(row)[6]
    real_rank.append((row, arr))

real_rank = sorted(real_rank, reverse=True, key=lambda r: r[1])
real_ranking_result_by_object_index = [1 for i in range(len(ranking_result) + 1)]
for i in range(len(real_rank)):
    real_ranking_result_by_object_index[real_rank[i][0]] = i + 1
for i in range(len(real_rank)):
    write_file(sheet3, 0, i, real_ranking_result_by_object_index[i + 1])

book.save('computer_hardware_data_set_clustering_ranking_result.xls')
