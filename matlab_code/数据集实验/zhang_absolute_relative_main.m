clc
close all
clear all
X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\winequality-white','H2:K4899');
J = [2 1 2 1];
% X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\winequality-red','F2:K1600');
% J=[2 1 2 2 1 1]
% X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\tripadvisor_review','B2:K981');
% J=[1 1 1 1 1 1 1 1 1 1]
% X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\2014_and_2015_CSM_dataset','C2:J188');
% J=[1 1 2 1 1 1 2 1]
% X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\Concrete_Data','A2:H1031');
% J=[1 1 2 2 1 1 1 1]


[m,n] = size(X);
A=zeros(m,n);
for j = 1:n
	if J(j) == 1
       A(:,j) = X(:,j)./max(X(:,j));
       %A(:,j) = X(:,j)./max(X(:,j));
  %A(:,j) = (X(:,j)-min(X(:,j)))./(max(X(:,j))-min(X(:,j)));
    else
        %A(:,j) = min(X(:,j))./X(:,j);
        A(:,j) = 1-X(:,j)./max(X(:,j));
   %A(:,j) = (max(X(:,j))-X(:,j))./(max(X(:,j))-min(X(:,j)));
	end    
end
TA=A;
%W=[0.125,0.2,0.1,0.25,0.1,0.2];
%H=[ 0.33    0.37    0.45     0.33    0.41     0.35];%面向准则的模糊概念H，h_j
W=ones(1,n).*(1/n);
H=mean(TA);
% H = ones(1,n).*0.1;
% H = [0.05,0.05,0.05,0.05];

%张凯TFS
Q=0.4;%风险规避系数
[PX5_jue,f_DOM1_jue,f_DOM2_jue,f_DOM3_jue,juedui_POS,juedui_NEG]=lunwen5_jue(TA,W,H,Q);
[PX5_xiang,f_DOM1_xiang,f_DOM2_xiang,f_DOM3_xiang,xiangdui_POS,xiangdui_NEG]=lunwen5_xiang(TA,W,H,Q);

% 
% data = [PX5_jue',PX5_xiang'];                           % 将数据组集到data
% [m_data, n_data] = size(data);            
% data_cell = mat2cell(data, ones(m_data,1), ones(n_data,1)); % 将data切割成m_data*n_data的cell矩阵
% title = {'张凯TFS绝对', '张凯TFS相对'};  % 添加变量名称
% result = [title; data_cell];   % 将变量名称和数值组集到result
% s=xlswrite('zhang_xiang_and_jue.xlsx', result);    % 将result写入到paixu.xls文件中
data = [PX5_jue;PX5_xiang];
writematrix(data,'winequality_white_zhang_relative_and_absolute_ranking_result.csv');     % 写入csv
% writematrix(data,'winequality_red_zhang_relative_and_absolute_ranking_result.csv');     % 写入csv
% writematrix(data,'tripadvisor_review_zhang_relative_and_absolute_ranking_result.csv');     % 写入csv
% writematrix(data,'CSM_zhang_relative_and_absolute_ranking_result.csv');     % 写入csv
% writematrix(data,'concrete_zhang_relative_and_absolute_ranking_result.csv');     % 写入csv



