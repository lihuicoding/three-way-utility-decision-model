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
    b = [i / 100 for i in range(30, 31)]
    for k in range(len(b)):
        # 输入对象和准则的个数n,m,效益趋向因子b
        # n = int(input("输入对象的个数："))
        # m = int(input("输入准则的个数："))
        n = 8
        m = 8
        # b = float(input("输入效益趋向因子："))

        # 权重向量W
        W = [0.15, 0.2, 0.05, 0.1, 0.15, 0.1, 0.1, 0.15]

        # 读取数据，构造信息矩阵S
        S = [[0.0 for j in range(m)] for i in range(n)]

        with open("data.txt", encoding="utf-8") as f:
            line = f.readline()
            i = 0
            while line != '':
                j = 0
                spl = line.split(" ")
                for c in spl:
                    S[i][j] = float(c)
                    j += 1
                line = f.readline()
                i += 1
        # print(S)

        # 最小要求L
        L = [0.73, 0.67, 0.55, 0.83, 0.41, 0.35, 0.45, 0.68]
        # 计算条件概率
        P = [0.0 for i in range(n)]
        for i in range(n):
            s = 0
            for j in range(m):
                if S[i][j] >= L[j]:
                    s += W[j]
            P[i] = s
        print(P)
        # P = [0.3500, 0.5500, 0.4500, 0.5500, 0.3500, 0.6385, 0.5990, 0.4500]

        # 计算损失函数
        BP = [0.0 for i in range(n)]
        NP = [0.0 for i in range(n)]
        PN = [0.0 for i in range(n)]
        BN = [0.0 for i in range(n)]
        for i in range(n):
            sum_1 = 0
            sum_2 = 0
            for j in range(m):
                sum_1 += W[j] * max(0, S[i][j] - L[j])
                sum_2 += W[j] * max(0, L[j] - S[i][j])
            NP[i] = sum_1
            BP[i] = sum_1 * b[k]
            PN[i] = sum_2
            BN[i] = sum_2 * b[k]
        # print(BP)
        # print(NP)
        # print(PN)
        # print(BN)
        # 计算阈值
        alpha = [0.0 for i in range(n)]
        beta = [0.0 for i in range(n)]
        gamma = [0.0 for i in range(n)]
        for i in range(n):
            alpha[i] = (PN[i] - BN[i]) / ((PN[i] - BN[i]) + BP[i])
            beta[i] = BN[i] / (BN[i] + (NP[i] - BP[i]))
            gamma[i] = PN[i] / (PN[i] + NP[i])
        # print(alpha)
        # print(beta)
        # print(gamma)

        # 进行三支聚类
        POS = []
        BND = []
        NEG = []
        EU = [0.0 for i in range(n)]
        for i in range(n):
            if P[i] >= alpha[i]:
                POS.append((i + 1, PN[i] * (1-P[i])))
            elif P[i] <= beta[i]:
                NEG.append((i + 1, P[i] * NP[i]))
            else:
                BND.append((i + 1, BP[i] * P[i] + BN[i] * (1 - P[i])))
        POS = sorted(POS, reverse=False, key=lambda pos: pos[1])
        BND = sorted(BND, reverse=False, key=lambda bnd: bnd[1])
        NEG = sorted(NEG, reverse=False, key=lambda neg: neg[1])
        print("基于损失:", file=output)
        print(POS, file=output)
        print(BND, file=output)
        print(NEG, file=output)
        ranking_result = [pos[0] for pos in POS] + [bnd[0] for bnd in BND] + [neg[0] for neg in NEG]
        print(ranking_result, file=output)

    output.close()
