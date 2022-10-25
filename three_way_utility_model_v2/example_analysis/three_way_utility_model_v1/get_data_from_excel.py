import xlrd

# 导入需要读取的第一个Excel表格的路径
data = xlrd.open_workbook(r'C:\Users\李辉\Desktop\湖南师范大学本科毕业设计\数据\machine.xlsx')
table_1 = data.sheets()[0]
# 创建一个空列表，存储Excel数据
table = []


# 将excel表格内容导入到tables列表中
def import_excel(excel):
    for row in range(1, excel.nrows):
        arr = excel.row_values(row)[:6]
        table.append(arr)


if __name__ == '__main__':
    import_excel(table_1)
    print(table)
    print(type(table))
