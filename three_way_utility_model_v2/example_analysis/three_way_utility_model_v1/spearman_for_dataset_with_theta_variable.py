'''
随着theta的变化，数据集的排序结果与真实结果的Spearman相关系数
'''
import xlrd
import xlwt
import pandas as pd

data = xlrd.open_workbook(r'computer_hardware_data_set_clustering_ranking_result.xls')
table_1 = data.sheets()[1]
table_2 = data.sheets()[2]

# 创建一个空列表，存储Excel数据
table = []
real = []

# 读取数据
# 将excel表格内容导入到tables列表中
for row in range(table_1.nrows):
    arr = table_1.row_values(row)
    table.append(arr)
# print(table)

for row in range(table_2.nrows):
    arr = table_2.row_values(row)
    real = arr
# print(real)


# 写入数据
book = xlwt.Workbook(encoding='utf-8')
sheet1 = book.add_sheet(u'Sheet1', cell_overwrite_ok=True)
sheet2 = book.add_sheet(u'Sheet2', cell_overwrite_ok=True)


# 向单元格添加数据
def write_file(sheet, r, c, value):
    sheet.write(r, c, value)


# 计算
# 在进行计算的时候不需要索引，因为读取出来的数据已经是索引了
for i in range(len(table)):
    s = float(format(pd.Series(table[i][1:]).corr(pd.Series(real), method='spearman'), '.4f'))
    write_file(sheet1, i, 0, table[i][0])  # theta
    write_file(sheet1, i, 1, s)  # spearman
    k = float(format(pd.Series(table[i][1:]).corr(pd.Series(real), method='kendall'), '.4f'))
    write_file(sheet2, i, 0, table[i][0])  # theta
    write_file(sheet2, i, 1, k)  # kendall

book.save('spearman_with_theta_to_real.xls')
