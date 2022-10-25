A = [[0.72, 0.45, 0.60, 0.32, 0.54],
     [0.52, 0.70, 0.60, 0.52, 0.58],
     [0.42, 0.80, 0.47, 0.85, 0.74],
     [0.50, 0.60, 0.48, 0.59, 0.60]]
w = [0.25, 0.1, 0.3, 0.15, 0.2]
l = [0.5, 0.6, 0.4, 0.4, 0.6]

for j in range(len(A)):
    PP = 0
    BP = 0
    NN = 0
    BN = 0
    for i in range(5):
        PP += w[i] * A[j][i] / (1 + l[i])
        NN += w[i] * (1 - A[j][i]) / (1 + l[i])
    BP = PP * 0.7
    BN = NN * 0.7
    print(PP, end=" ")
    print(BP, end=" ")
    print(NN, end=" ")
    print(BN, end=" ")
    print()



# # example_analysis-11
# """
# input:
# 1.对象的个数n,准则的个数m
# 2.效益趋向因子b
# 3.权重向量W
# 4.模糊概念L
# output:
# 所有对象聚类和排序的结果
# """
# b = 0.7
# n = 4
# m = 5
# # b = float(input("输入效益趋向因子："))
#
# # 权重向量W
# W = [0.15, 0.1, 0.3, 0.25, 0.2]
#
# # 读取数据，构造信息矩阵S
# S = [[0.52, 0.56, 0.64, 0.54, 0.52],
#      [0.45, 0.65, 0.62, 0.57, 0.65],
#      [0.74, 0.48, 0.94, 0.54, 0.72],
#      [0.65, 0.72, 0.72, 0.62, 0.56]]
#
# # 最小要求L
# L = [0.6, 0.5, 0.7, 0.55, 0.6]
# # 计算条件概率
# P = [0.0 for i in range(n)]
# for i in range(n):
#     s = 0
#     for j in range(m):
#         if S[i][j] >= L[j]:
#             s += W[j]
#     P[i] = s
# print(P)
# # P = [0.3500, 0.5500, 0.4500, 0.5500, 0.3500, 0.6385, 0.5990, 0.4500]
#
# # 计算效用函数
# PP = [0.0 for i in range(n)]
# BP = [0.0 for i in range(n)]
# BN = [0.0 for i in range(n)]
# NN = [0.0 for i in range(n)]
# for i in range(n):
#     sum_1 = 0
#     sum_2 = 0
#     for j in range(m):
#         sum_1 += W[j] * S[i][j] / (1 + L[j])
#         sum_2 += W[j] * ((1 - S[i][j]) / (1 + L[j]))
#     PP[i] = sum_1
#     BP[i] = sum_1 * b
#     NN[i] = sum_2
#     BN[i] = sum_2 * b
#
# # 计算阈值
# alpha = [0.0 for i in range(n)]
# beta = [0.0 for i in range(n)]
# gamma = [0.0 for i in range(n)]
# for i in range(n):
#     alpha[i] = BN[i] / (PP[i] - BP[i] + BN[i])
#     beta[i] = (NN[i] - BN[i]) / (BP[i] + NN[i] - BN[i])
#     gamma[i] = NN[i] / (PP[i] + NN[i])
# print(alpha)
# print(beta)
# print(gamma)
#
# # 进行三支聚类
# POS = []
# BND = []
# NEG = []
# EU = [0.0 for i in range(n)]
# for i in range(n):
#     if P[i] >= alpha[i]:
#         POS.append((i + 1, PP[i] * P[i]))
#     elif P[i] <= beta[i]:
#         NEG.append((i + 1, (1 - P[i]) * NN[i]))
#     else:
#         BND.append((i + 1, BP[i] * P[i] + BN[i] * (1 - P[i])))
# POS = sorted(POS, reverse=True, key=lambda pos: pos[1])
# BND = sorted(BND, reverse=True, key=lambda bnd: bnd[1])
# NEG = sorted(NEG, reverse=True, key=lambda neg: neg[1])
# print("新的基于效用方法:")
# print(POS)
# print(BND)
# print(NEG)
# ranking_result = [pos[0] for pos in POS] + [bnd[0] for bnd in BND] + [neg[0] for neg in NEG]
# print(ranking_result)
