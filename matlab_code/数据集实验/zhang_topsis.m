clc
clear all
close all
T=zhang_bo2_dan_x1();%x1,阈值越大越好
TT=zhang_bo2_dan_x2();%x2，阈值越小越好
T1=T./(T+TT) 
[mn1,nm1]=sort(T1(1,:),'descend');%%%%%阿尔法
nm1
[mn2,nm2]=sort(T1(2,:),'descend');%%%%%伽玛
nm2
[mn3,nm3]=sort(T1(3,:),'descend'); %%%%%贝塔
nm3

% data = [nm1',nm2',nm3'];                           % 将数据组集到data
% [m_data, n_data] = size(data);            
% data_cell = mat2cell(data, ones(m_data,1), ones(n_data,1)); % 将data切割成m_data*n_data的cell矩阵
% title = {'alpha', 'gamma', 'beta'};  % 添加变量名称
% result = [title; data_cell];   % 将变量名称和数值组集到result
% s=xlswrite('zhang_2_topsis.xlsx', result);    % 将result写入到paixu.xls文件中

data = [nm1];
writematrix(data,'winequality_white_zhang_topsis_ranking_result.csv');     % 写入csv
% writematrix(data,'winequality_red_zhang_topsis_ranking_result.csv');     % 写入csv
% writematrix(data,'tripadvisor_review_zhang_topsis_ranking_result.csv');     % 写入csv
% writematrix(data,'CSM_zhang_topsis_ranking_result.csv');     % 写入csv
% writematrix(data,'concrete_zhang_topsis_ranking_result.csv');     % 写入csv