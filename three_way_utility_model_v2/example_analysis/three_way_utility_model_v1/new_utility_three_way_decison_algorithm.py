"""
input:
1.对象的个数n,准则的个数m
2.效益趋向因子b
3.权重向量W
4.模糊概念L
output:
所有对象聚类和排序的结果
"""
with open('output.txt', 'a', encoding='utf-8') as output:
    b = [i / 100 for i in range(70, 71)]  # 效用趋向因子b
    for k in range(len(b)):
        # 权重向量W
        W = [0.20, 0.25, 0.30, 0.14, 0.03, 0.08]

        # 读取数据，构造信息矩阵S
        S = []
        with open("normalized_data.txt", encoding="utf-8") as f:
            line = f.readline()
            while line != '':
                row = line.split(" ")
                row = [float(i) for i in row]
                S.append(row)
                line = f.readline()
            f.close()
        n = len(S)  # 对象的个数
        m = len(S[0])  # 准则的个数

        # 最小要求L
        L = [0.23, 0.06, 0.19, 0.25, 0.50, 0.19]
        # 计算条件概率
        P = [0.0 for i in range(n)]
        for i in range(n):
            s = 0
            for j in range(m):
                if S[i][j] >= L[j]:
                    s += W[j]
            P[i] = s
        print(P)

        # 计算效用函数
        PP = [0.0 for i in range(n)]
        BP = [0.0 for i in range(n)]
        BN = [0.0 for i in range(n)]
        NN = [0.0 for i in range(n)]
        for i in range(n):
            sum_1 = 0
            sum_2 = 0
            for j in range(m):
                sum_1 += W[j] * S[i][j] / (1 + L[j])
                sum_2 += W[j] * ((1 - S[i][j]) / (1 + L[j]))
            PP[i] = sum_1
            BP[i] = sum_1 * b[k]
            NN[i] = sum_2
            BN[i] = sum_2 * b[k]
        print("PP：", PP)
        print("BP：", BP)
        print("BN：", BN)
        print("NN：", NN)

        # 计算阈值
        alpha = [0.0 for i in range(n)]
        beta = [0.0 for i in range(n)]
        gamma = [0.0 for i in range(n)]
        for i in range(n):
            alpha[i] = BN[i] / (PP[i] - BP[i] + BN[i])
            beta[i] = (NN[i] - BN[i]) / (BP[i] + NN[i] - BN[i])
            gamma[i] = NN[i] / (PP[i] + NN[i])
        print("alpha：", alpha)
        print("beta：", beta)
        print("gamma：", gamma)

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
        POS = sorted(POS, reverse=True, key=lambda pos: pos[1])
        BND = sorted(BND, reverse=True, key=lambda bnd: bnd[1])
        NEG = sorted(NEG, reverse=True, key=lambda neg: neg[1])
        print("新的基于效用方法:")
        print(POS)
        print(BND)
        print(NEG)
        ranking_result = [pos[0] for pos in POS] + [bnd[0] for bnd in BND] + [neg[0] for neg in NEG]
        print(ranking_result)

    output.close()
