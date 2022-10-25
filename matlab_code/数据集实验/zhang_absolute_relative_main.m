clc
close all
clear all
X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\winequality-white','H2:K4899');
J = [2 1 2 1];
% X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\winequality-red','F2:K1600');
% J=[2 1 2 2 1 1]
% X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\tripadvisor_review','B2:K981');
% J=[1 1 1 1 1 1 1 1 1 1]
% X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\2014_and_2015_CSM_dataset','C2:J188');
% J=[1 1 2 1 1 1 2 1]
% X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\Concrete_Data','A2:H1031');
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
%H=[ 0.33    0.37    0.45     0.33    0.41     0.35];%����׼���ģ������H��h_j
W=ones(1,n).*(1/n);
H=mean(TA);
% H = ones(1,n).*0.1;
% H = [0.05,0.05,0.05,0.05];

%�ſ�TFS
Q=0.4;%���չ��ϵ��
[PX5_jue,f_DOM1_jue,f_DOM2_jue,f_DOM3_jue,juedui_POS,juedui_NEG]=lunwen5_jue(TA,W,H,Q);
[PX5_xiang,f_DOM1_xiang,f_DOM2_xiang,f_DOM3_xiang,xiangdui_POS,xiangdui_NEG]=lunwen5_xiang(TA,W,H,Q);

% 
% data = [PX5_jue',PX5_xiang'];                           % �������鼯��data
% [m_data, n_data] = size(data);            
% data_cell = mat2cell(data, ones(m_data,1), ones(n_data,1)); % ��data�и��m_data*n_data��cell����
% title = {'�ſ�TFS����', '�ſ�TFS���'};  % ��ӱ�������
% result = [title; data_cell];   % ���������ƺ���ֵ�鼯��result
% s=xlswrite('zhang_xiang_and_jue.xlsx', result);    % ��resultд�뵽paixu.xls�ļ���
data = [PX5_jue;PX5_xiang];
writematrix(data,'winequality_white_zhang_relative_and_absolute_ranking_result.csv');     % д��csv
% writematrix(data,'winequality_red_zhang_relative_and_absolute_ranking_result.csv');     % д��csv
% writematrix(data,'tripadvisor_review_zhang_relative_and_absolute_ranking_result.csv');     % д��csv
% writematrix(data,'CSM_zhang_relative_and_absolute_ranking_result.csv');     % д��csv
% writematrix(data,'concrete_zhang_relative_and_absolute_ranking_result.csv');     % д��csv



