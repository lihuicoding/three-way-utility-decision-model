import read_file
import write_file


# 如果信息表中的属性值全都不为0，采用此正规化方法
# data normalize function
# def data_normalize_fun(Mat, is_benefit, normalized_data):
#     # 计算每一列的最大最小值
#     max_min_value_of_column = Mat[0].copy()
#     for i in range(len(Mat)):
#         for j in range(len(Mat[i])):
#             if is_benefit[j] == 1:  # 表示为效益准则,求列的最大值
#                 if Mat[i][j] > max_min_value_of_column[j]:
#                     max_min_value_of_column[j] = Mat[i][j]
#             else:  # 成本准则，求列的最小值
#                 if Mat[i][j] < max_min_value_of_column[j]:
#                     max_min_value_of_column[j] = Mat[i][j]
#     # 正规化
#     for i in range(len(Mat)):
#         for j in range(len(Mat[i])):
#             if is_benefit[j] == 1:  # 表示为效益准则
#                 normalized_data[i][j] = Mat[i][j] / max_min_value_of_column[j]
#             else:  # 成本准则
#                 normalized_data[i][j] = max_min_value_of_column[j] / Mat[i][j]
#     for i in range(len(normalized_data)):
#         write_file.write_file_to_csv('normalized_data.csv', normalized_data[i])

# 如果信息表中属性值含0，采用此正规化方法
def data_normalize_fun(Mat, is_benefit, normalized_data):
    # 计算每一列的最大值
    max_min_value_of_column = Mat[0].copy()
    for i in range(len(Mat)):
        for j in range(len(Mat[i])):
            if Mat[i][j] > max_min_value_of_column[j]:
                max_min_value_of_column[j] = Mat[i][j]
    # 正规化
    for i in range(len(Mat)):
        for j in range(len(Mat[i])):
            if is_benefit[j] == 1:  # 表示为效益准则
                normalized_data[i][j] = Mat[i][j] / max_min_value_of_column[j]
            else:  # 成本准则
                normalized_data[i][j] = 1 - Mat[i][j] / max_min_value_of_column[j]
    for i in range(len(normalized_data)):
        write_file.write_file_to_csv('normalized_data.csv', normalized_data[i])


def three_way_utility_model(normalized_data, W, L, theta, data_set_name):
    n = len(normalized_data)  # 对象的个数
    m = len(normalized_data[0])  # 准则的个数

    # 计算条件概率
    P = [0.0 for i in range(n)]
    for i in range(n):
        s = 0
        for j in range(m):
            if normalized_data[i][j] >= L[j]:
                s += W[j]
        P[i] = s

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

    # 计算阈值
    alpha = [0.0 for i in range(n)]
    beta = [0.0 for i in range(n)]
    gamma = [0.0 for i in range(n)]
    for i in range(n):
        alpha[i] = BN[i] / (PP[i] - BP[i] + BN[i])
        beta[i] = (NN[i] - BN[i]) / (BP[i] + NN[i] - BN[i])
        gamma[i] = NN[i] / (PP[i] + NN[i])

    # 进行三支聚类
    POS = []
    BND = []
    NEG = []
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

    # 保存分类结果
    write_file.write_file_to_csv(data_set_name + '_classification_result.csv', [theta, len(POS), len(BND), len(NEG)])
    # 保存排序结果
    write_file.write_file_to_csv(data_set_name + '_ranking_result.csv', [theta] + ranking_result_by_object_index[1:])


if __name__ == '__main__':
    # computer hardware data set
    # W = [0.20, 0.25, 0.30, 0.14, 0.03, 0.08]
    # L = [0.23, 0.06, 0.19, 0.25, 0.50, 0.19]
    # L = [0.15454545454545454, 0.03125, 0.09375, 0.25, 0.15384615384615385, 0.13636363636363635]
    # is_benefit = [0, 1, 1, 1, 1, 1]

    # concrete compressive strength data set
    # is_benefit = [1, 1, 0, 0, 1, 1, 1, 1]
    # W = [1/8 for i in range(8)]
    # # L = [0.1, 0.1, 1.0, 0.0, 0.0, 0.0, 0.0, 0.07] 0.59
    # L = [0.4, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.07]
    # # L = [0.4, 0.0, 1.0, 0.01, 0.0, 0.0, 0.0, 0.07] 0.62
    # Mat = []
    # read_file.read_file_as_mat('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\Concrete_Data.xls', 'xls',
    #                            Mat,
    #                            1, 0, 8)

    # CSM Dataset 2014 and 2015
    # is_benefit = [1, 1, 0, 1, 1, 1, 0, 1]
    # W = [1 / 8 for i in range(8)]
    # # L = [0.1, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001]
    # L = [0.1, 0.0001, 0.0001, 0.0001, 0.0001, 0.00001, 0.00001, 0.00001]
    # # L = [0.1, 0.0001, 0.00001, 0.0001, 0.00001, 0.0001, 0.00001, 0.0001]
    # Mat = []
    # read_file.read_file_as_mat('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\2014_and_2015_CSM_dataset.xlsx', 'xlsx',
    #                            Mat,
    #                            1, 2, 10)

    # tripadvisor_review data set
    # is_benefit = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    # W = [1 / 10 for i in range(10)]
    # L = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
    # Mat = []
    # read_file.read_file_as_mat('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\tripadvisor_review.xlsx', 'xlsx',
    #                            Mat,
    #                            1, 1, 11)

    # winequality-white data set
    is_benefit = [0, 1, 0, 1]
    W = [1 / 4 for i in range(4)]
    # L = [0.1, 0.1, 0.1, 0.1]
    L = [0.05, 0.05, 0.05, 0.05]
    Mat = []
    read_file.read_file_as_mat('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\winequality-white.xlsx', 'xlsx',
                               Mat,
                               1, 1, 5)

    # # winequality-red data set
    # is_benefit = [0, 1, 0, 0, 1, 1]
    # W = [1 / 6 for i in range(6)]
    # L = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1]
    # Mat = []
    # read_file.read_file_as_mat('C:\\Users\\李辉\\Desktop\\ASOC-D-22-02636\\添加数据集\\winequality-red.xlsx', 'xlsx',
    #                            Mat,
    #                            1, 5, 11)

    m = len(Mat)
    n = len(Mat[0])
    normalized_data = [[0.0 for i in range(n)] for j in range(m)]
    data_normalize_fun(Mat, is_benefit, normalized_data)
    # three_way_utility_model_v2(normalized_data, W, L, 0.7, 'computer')
    theta = 0.50
    while theta < 1.00:
        theta += 0.01
        if theta >= 1.00:
            theta = 1.00
        three_way_utility_model(normalized_data, W, L, theta, 'winequality_white')
