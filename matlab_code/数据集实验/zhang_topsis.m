clc
clear all
close all
T=zhang_bo2_dan_x1();%x1,��ֵԽ��Խ��
TT=zhang_bo2_dan_x2();%x2����ֵԽСԽ��
T1=T./(T+TT) 
[mn1,nm1]=sort(T1(1,:),'descend');%%%%%������
nm1
[mn2,nm2]=sort(T1(2,:),'descend');%%%%%٤��
nm2
[mn3,nm3]=sort(T1(3,:),'descend'); %%%%%����
nm3

% data = [nm1',nm2',nm3'];                           % �������鼯��data
% [m_data, n_data] = size(data);            
% data_cell = mat2cell(data, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
% title = {'alpha', 'gamma', 'beta'};  % ��ӱ�������
% result = [title; data_cell];   % ���������ƺ���ֵ�鼯��result
% s=xlswrite('zhang_2_topsis.xlsx', result);    % ��resultд�뵽paixu.xls�ļ���

data = [nm1];
writematrix(data,'winequality_white_zhang_topsis_ranking_result.csv');     % д��csv
% writematrix(data,'winequality_red_zhang_topsis_ranking_result.csv');     % д��csv
% writematrix(data,'tripadvisor_review_zhang_topsis_ranking_result.csv');     % д��csv
% writematrix(data,'CSM_zhang_topsis_ranking_result.csv');     % д��csv
% writematrix(data,'concrete_zhang_topsis_ranking_result.csv');     % д��csv