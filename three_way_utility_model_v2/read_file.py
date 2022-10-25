import csv
import xlrd


# 读取表格数据,Mat为保存数据的表
def read_file_as_mat(path, file_type, Mat, row_num, begin_column_num, end_column_num):
    if file_type == 'csv':  # csv类型的文件
        with open(path) as f:
            csv_reader = csv.reader(f)
            for row in csv_reader:
                row = [float(i) for i in row]
                Mat.append(row)
            f.close()
    elif file_type == 'xls' or file_type == 'xlsx':  # xls类型的文件
        data = xlrd.open_workbook(path)
        table = data.sheets()[0]
        for i in range(row_num, table.nrows):
            row = table.row_values(i)[begin_column_num:end_column_num]
            row = [float(i) for i in row]
            Mat.append(row)
    else:
        pass
