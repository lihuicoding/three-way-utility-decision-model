'''
相关系数分析
1.spearman correlation coefficient(斯皮尔曼相关系数）
2.kendall correlation coefficient(肯德尔相关系数）
3.person correlation coefficient(皮尔森相关系数）
'''

# spearman correlation coefficient
import pandas as pd
import numpy as np

# 原始数据
X1 = pd.Series([7, 2, 6, 4, 1, 3, 5, 8])
Y1 = pd.Series([7, 2, 4, 6, 8, 5, 3, 1])

# 处理数据删除Nan
x1 = X1.dropna()
y1 = Y1.dropna()
n = x1.count()
x1.index = np.arange(n)
y1.index = np.arange(n)

# 分部计算
d = (x1.sort_values().index - y1.sort_values().index) ** 2
dd = d.to_series().sum()

p = 1 - n * dd / (n * (n ** 2 - 1))

# s.corr()函数计算
r = x1.corr(y1, method='spearman')
print('斯皮尔曼系数：', r, p)

# kendall correlation coefficient
import pandas as pd
import numpy as np

# 原始数据
x = pd.Series([6, 5, 1, 8, 3, 2, 7, 4])
y = pd.Series([6, 8, 3, 1, 5, 7, 4, 2])
r = x.corr(y, method="kendall")  # -0.2611165
print('肯德尔系数：', r)

# person correlation coefficient
import pandas as pd
import numpy as np

# 原始数据
X1 = pd.Series([6, 3, 8, 1, 5, 4, 7, 2])
Y1 = pd.Series([6, 8, 3, 1, 5, 7, 4, 2])

X1.mean()  # 平均值# 3.5
Y1.mean()  # 2.4
X1.var()  # 方差#3.5
Y1.var()  # 2.9760000000000004

X1.std()  # 标准差不能为0# 1.8708286933869707
Y1.std()  # 标准差不能为0#1.725108692227826
X1.cov(Y1)  # 协方差#3.0600000000000005

print('皮尔森相关性系数:', X1.corr(Y1, method="pearson"))  # 皮尔森相关性系数 #0.948136664010285
print('皮尔森相关性系数:', X1.cov(Y1) / (X1.std() * Y1.std()))  # 皮尔森相关性系数 # 0.948136664010285
