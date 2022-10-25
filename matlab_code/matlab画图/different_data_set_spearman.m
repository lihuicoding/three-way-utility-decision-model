clc 
close all
clear all

[data_1]=xlsread('concrete_spearman.xlsx');
[data_2]=xlsread('CSM_spearman.xlsx');
[data_3]=xlsread('tripadvisor_review_spearman.xlsx');
[data_4]=xlsread('winequality_red_spearman.xlsx');
[data_5]=xlsread('winequality_white_spearman.xlsx');

row_1=data_1(20,2:8);    % theta=0.70
row_2=data_2(38,2:8);    % theta=0.88
row_3=data_3(29,2:8);    % theta=0.89
row_4=data_4(10,2:8);    % theta=0.60
row_5=data_5(25,2:8);    % theta=0.75

figure(1);
hold on;
plot(row_1,'--bd','LineWidth',3.0,'Markersize',10);
plot(row_2,'--ro','LineWidth',3.0,'Markersize',10);
plot(row_3,'--mv','LineWidth',3.0,'Markersize',10);
plot(row_4,'--c*','LineWidth',3.0,'Markersize',10);
plot(row_5,'--yh','LineWidth',3.0,'Markersize',10);
% plot(mydata(8,:),'-c*','LineWidth',2.0,'Markersize',10);
% plot(mydata(9,:),'--ro','LineWidth',2.0,'Markersize',10);

set(gca,'YLim',[0 1],'FontSize',18);%Y轴的数据显示范围
set(gca,'xticklabel',{'D1','D2','D3','D4','D5','D6','D7'},'FontSize',18);
grid on;
L = legend('Data set 1','Data set 2','Data set 3','Data set 4','Data set 5','location','NorthEast','FontSize',15);
set(L,'Orientation','horizon');     % legend横排
set(L,'Box','off');    % 不显示边框
xlabel('Methods','FontSize',18);
ylabel('SRCC','FontSize',18);







