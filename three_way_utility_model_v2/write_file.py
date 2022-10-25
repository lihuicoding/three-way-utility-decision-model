import csv
import xlwt


def write_file_to_csv(path, row):
    # 向csv文件中写数据
    with open(path, 'a', newline='') as f:
        writer_csv = csv.writer(f)
        writer_csv.writerow(row)
        f.close()


def write_file_to_xls(path, row_num, column_num, value):
    # 向Excel中写入数据
    book = xlwt.Workbook(encoding='utf-8')
    sheet1 = book.add_sheet(u'Sheet1', cell_overwrite_ok=True)
    # 向单元格添加数据
    sheet1.write(row_num, column_num, value)
    book.save(path)
