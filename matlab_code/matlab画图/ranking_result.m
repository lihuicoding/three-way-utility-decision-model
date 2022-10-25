clc
close all
clear all

data_1 = csvread('three_way_utility_model_v2\our_model_result\concrete_ranking_result.csv',0,1);
data_2 = csvread('three_way_utility_model_v2\our_model_result\CSM_ranking_result.csv',0,1);
data_3 = csvread('three_way_utility_model_v2\our_model_result\tripadvisor_review_ranking_result.csv',0,1);
data_4 = csvread('three_way_utility_model_v2\our_model_result\winequality_red_ranking_result.csv',0,1);
data_5 = csvread('three_way_utility_model_v2\our_model_result\winequality_white_ranking_result.csv',0,1);

[m_1,n_1] = size(data_1);
[m_2,n_2] = size(data_2);
[m_3,n_3] = size(data_3);
[m_4,n_4] = size(data_4);
[m_5,n_5] = size(data_5);

% 各个数据集的排序结果
rank_1=data_1(20,1:n_1);    % theta=0.70
rank_2=data_2(38,1:n_2);    % theta=0.88
rank_3=data_3(29,1:n_3);    % theta=0.89
rank_4=data_4(10,1:n_4);    % theta=0.60
rank_5=data_5(25,1:n_5);    % theta=0.75

% 对象X轴
objects_1=(1:n_1);
objects_2=(1:n_2);
objects_3=(1:n_3);
objects_4=(1:n_4);
objects_5=(1:n_5);

figure;
subplot(5,1,1);
bar(objects_1,rank_1,'FaceColor','g');
xlabel('Objects');
ylabel('Ranking');
legend('Data set 1');

subplot(5,1,2);
bar(objects_2,rank_2,'FaceColor','m');
xlabel('Objects');
ylabel('Ranking');
legend('Data set 2');

subplot(5,1,3);
bar(objects_3,rank_3,'FaceColor','c');
xlabel('Objects');
ylabel('Ranking');
legend('Data set 3');

subplot(5,1,4);
bar(objects_4,rank_4,'FaceColor','y');
xlabel('Objects');
ylabel('Ranking');
legend('Data set 4');

subplot(5,1,5);
bar(objects_5,rank_5,'FaceColor','b');
xlabel('Objects');
ylabel('Ranking');
legend('Data set 5');