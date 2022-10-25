clc
close all
clear all

% concrete���ݼ�
data_1 = csvread('three_way_utility_model_v2\our_model_result\compare_with_topsis_method\concrete_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_2 = csvread('three_way_utility_model_v2\our_model_result\compare_with_waa_method\concrete_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_3 = csvread('three_way_utility_model_v2\our_model_result\compare_with_jia_and_liu_method\concrete_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_4 = csvread('three_way_utility_model_v2\our_model_result\compare_with_ye_method\concrete_spearman_and_kendall_rusult.csv',0,0);
data_5 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_topsis_method\concrete_spearman_and_kendall_rusult.csv',0,0);
data_6 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_relative_method\concrete_spearman_and_kendall_rusult.csv',0,0);
data_7 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_absolute_method\concrete_spearman_and_kendall_rusult.csv',0,0);
data_s = [data_1(:,1:2), data_2(:,2:2), data_3(:,2:2), data_4(:,2:2), data_5(:,2:2), data_6(:,2:2), data_7(:,2:2)]; % spearman
data_k = [data_1(:,1:1), data_1(:,3:3), data_2(:,3:3), data_3(:,3:3), data_4(:,3:3), data_5(:,3:3), data_6(:,3:3), data_7(:,3:3)]; % kendalll

title = {'theta', 'topsis', 'waa', 'jia_liu', 'ye', 'zhang_topsis', 'zhang_relative', 'zhang_absolute'};  % ��ӱ�������
[m_data, n_data] = size(data_s);            
data_s = mat2cell(data_s, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_s];   % ���������ƺ���ֵ�鼯��result
s = xlswrite('concrete_spearman.xlsx', result);    % ��resultд�뵽spearman.xls�ļ���           
data_k = mat2cell(data_k, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_k];
k = xlswrite('concrete_kendall.xlsx', result);  % ��resultд�뵽kendall.xls�ļ���


% CSM���ݼ�
data_1 = csvread('three_way_utility_model_v2\our_model_result\compare_with_topsis_method\CSM_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_2 = csvread('three_way_utility_model_v2\our_model_result\compare_with_waa_method\CSM_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_3 = csvread('three_way_utility_model_v2\our_model_result\compare_with_jia_and_liu_method\CSM_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_4 = csvread('three_way_utility_model_v2\our_model_result\compare_with_ye_method\CSM_spearman_and_kendall_rusult.csv',0,0);
data_5 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_topsis_method\CSM_spearman_and_kendall_rusult.csv',0,0);
data_6 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_relative_method\CSM_spearman_and_kendall_rusult.csv',0,0);
data_7 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_absolute_method\CSM_spearman_and_kendall_rusult.csv',0,0);
data_s = [data_1(:,1:2), data_2(:,2:2), data_3(:,2:2), data_4(:,2:2), data_5(:,2:2), data_6(:,2:2), data_7(:,2:2)]; % spearman
data_k = [data_1(:,1:1), data_1(:,3:3), data_2(:,3:3), data_3(:,3:3), data_4(:,3:3), data_5(:,3:3), data_6(:,3:3), data_7(:,3:3)]; % kendalll

title = {'theta', 'topsis', 'waa', 'jia_liu', 'ye', 'zhang_topsis', 'zhang_relative', 'zhang_absolute'};  % ��ӱ�������
[m_data, n_data] = size(data_s);            
data_s = mat2cell(data_s, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_s];   % ���������ƺ���ֵ�鼯��result
s = xlswrite('CSM_spearman.xlsx', result);    % ��resultд�뵽spearman.xls�ļ���           
data_k = mat2cell(data_k, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_k];
k = xlswrite('CSM_kendall.xlsx', result);  % ��resultд�뵽kendall.xls�ļ���


% tripadvisor_review���ݼ�
data_1 = csvread('three_way_utility_model_v2\our_model_result\compare_with_topsis_method\tripadvisor_review_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_2 = csvread('three_way_utility_model_v2\our_model_result\compare_with_waa_method\tripadvisor_review_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_3 = csvread('three_way_utility_model_v2\our_model_result\compare_with_jia_and_liu_method\tripadvisor_review_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_4 = csvread('three_way_utility_model_v2\our_model_result\compare_with_ye_method\tripadvisor_review_spearman_and_kendall_rusult.csv',0,0);
data_5 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_topsis_method\tripadvisor_review_spearman_and_kendall_rusult.csv',0,0);
data_6 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_relative_method\tripadvisor_review_spearman_and_kendall_rusult.csv',0,0);
data_7 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_absolute_method\tripadvisor_review_spearman_and_kendall_rusult.csv',0,0);
data_s = [data_1(:,1:2), data_2(:,2:2), data_3(:,2:2), data_4(:,2:2), data_5(:,2:2), data_6(:,2:2), data_7(:,2:2)]; % spearman
data_k = [data_1(:,1:1), data_1(:,3:3), data_2(:,3:3), data_3(:,3:3), data_4(:,3:3), data_5(:,3:3), data_6(:,3:3), data_7(:,3:3)]; % kendalll

title = {'theta', 'topsis', 'waa', 'jia_liu', 'ye', 'zhang_topsis', 'zhang_relative', 'zhang_absolute'};  % ��ӱ�������
[m_data, n_data] = size(data_s);            
data_s = mat2cell(data_s, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_s];   % ���������ƺ���ֵ�鼯��result
s = xlswrite('tripadvisor_review_spearman.xlsx', result);    % ��resultд�뵽spearman.xls�ļ���           
data_k = mat2cell(data_k, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_k];
k = xlswrite('tripadvisor_review_kendall.xlsx', result);  % ��resultд�뵽kendall.xls�ļ���



% winequality_red���ݼ�
data_1 = csvread('three_way_utility_model_v2\our_model_result\compare_with_topsis_method\winequality_red_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_2 = csvread('three_way_utility_model_v2\our_model_result\compare_with_waa_method\winequality_red_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_3 = csvread('three_way_utility_model_v2\our_model_result\compare_with_jia_and_liu_method\winequality_red_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_4 = csvread('three_way_utility_model_v2\our_model_result\compare_with_ye_method\winequality_red_spearman_and_kendall_rusult.csv',0,0);
data_5 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_topsis_method\winequality_red_spearman_and_kendall_rusult.csv',0,0);
data_6 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_relative_method\winequality_red_spearman_and_kendall_rusult.csv',0,0);
data_7 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_absolute_method\winequality_red_spearman_and_kendall_rusult.csv',0,0);
data_s = [data_1(:,1:2), data_2(:,2:2), data_3(:,2:2), data_4(:,2:2), data_5(:,2:2), data_6(:,2:2), data_7(:,2:2)]; % spearman
data_k = [data_1(:,1:1), data_1(:,3:3), data_2(:,3:3), data_3(:,3:3), data_4(:,3:3), data_5(:,3:3), data_6(:,3:3), data_7(:,3:3)]; % kendalll

title = {'theta', 'topsis', 'waa', 'jia_liu', 'ye', 'zhang_topsis', 'zhang_relative', 'zhang_absolute'};  % ��ӱ�������
[m_data, n_data] = size(data_s);            
data_s = mat2cell(data_s, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_s];   % ���������ƺ���ֵ�鼯��result
s = xlswrite('winequality_red_spearman.xlsx', result);    % ��resultд�뵽spearman.xls�ļ���           
data_k = mat2cell(data_k, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_k];
k = xlswrite('winequality_red_kendall.xlsx', result);  % ��resultд�뵽kendall.xls�ļ���



% winequality_white���ݼ�
data_1 = csvread('three_way_utility_model_v2\our_model_result\compare_with_topsis_method\winequality_white_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_2 = csvread('three_way_utility_model_v2\our_model_result\compare_with_waa_method\winequality_white_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_3 = csvread('three_way_utility_model_v2\our_model_result\compare_with_jia_and_liu_method\winequality_white_with_our_model_spearman_and_kendall_rusult.csv',0,0);
data_4 = csvread('three_way_utility_model_v2\our_model_result\compare_with_ye_method\winequality_white_spearman_and_kendall_rusult.csv',0,0);
data_5 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_topsis_method\winequality_white_spearman_and_kendall_rusult.csv',0,0);
data_6 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_relative_method\winequality_white_spearman_and_kendall_rusult.csv',0,0);
data_7 = csvread('three_way_utility_model_v2\our_model_result\compare_with_zhang_absolute_method\winequality_white_spearman_and_kendall_rusult.csv',0,0);
data_s = [data_1(:,1:2), data_2(:,2:2), data_3(:,2:2), data_4(:,2:2), data_5(:,2:2), data_6(:,2:2), data_7(:,2:2)]; % spearman
data_k = [data_1(:,1:1), data_1(:,3:3), data_2(:,3:3), data_3(:,3:3), data_4(:,3:3), data_5(:,3:3), data_6(:,3:3), data_7(:,3:3)]; % kendalll

title = {'theta', 'topsis', 'waa', 'jia_liu', 'ye', 'zhang_topsis', 'zhang_relative', 'zhang_absolute'};  % ��ӱ�������
[m_data, n_data] = size(data_s);            
data_s = mat2cell(data_s, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_s];   % ���������ƺ���ֵ�鼯��result
s = xlswrite('winequality_white_spearman.xlsx', result);    % ��resultд�뵽spearman.xls�ļ���           
data_k = mat2cell(data_k, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
result = [title; data_k];
k = xlswrite('winequality_white_kendall.xlsx', result);  % ��resultд�뵽kendall.xls�ļ���
