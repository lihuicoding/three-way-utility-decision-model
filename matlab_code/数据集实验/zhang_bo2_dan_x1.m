function rrr=zhang_bo2_dan_x1()
% RTR=[125    256    6000    256    16    128
%      29      8000    32000     32    8    32
%     110	    5000	 5000    142	8    64
%     25	    1310	2620	131	12	   24
%     75	    2000	8000	8	3	  24
%     140	    2000	32000	32	1   54
%     26	    16000	32000	64	8   24
%     160	   1000	    8000	16	1  	14];%%%行为对象，列为准则   
% X=RTR;
% [a,b]=size(X);
% J = [2 1 1 1 1 1];
% [m,n] = size(X);
% % 1.Normalization
% A = zeros(m,n);
% for j = 1:n
% 	if J(j) == 1
%        A(:,j) = X(:,j)./max(X(:,j));
%   %A(:,j) = (X(:,j)-min(X(:,j)))./(max(X(:,j))-min(X(:,j)));
%     else
%         A(:,j) = min(X(:,j))./X(:,j);
%    %A(:,j) = (max(X(:,j))-X(:,j))./(max(X(:,j))-min(X(:,j)));
% 	end    
% end
% TA=A 

% % X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\winequality-white','H2:K4899');
% X=xlsread('C:\Users\李辉\Desktop\ASOC-D-22-02636\添加数据集\tripadvisor_review','B2:K981');
% % J = [2 1 2 1];
% J = [1 1 1 1 1 1 1 1 1 1]

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

%-------------------------------------------------TOPSIS，获得模糊概念
% W = [0.20,0.25,0.30,0.14,0.03,0.08];
W=ones(1,n).*(1/n);
ba1=max(TA); %每一列最大值，正理想
ba2=min(TA);%每一列最小值，负理想
LD=[];
UD=[];
for aa1=1:m
    ld=sqrt(sum((TA(aa1,:)-ba2(1,:)).^2.*W));
    ud=sqrt(sum((TA(aa1,:)-ba1(1,:)).^2.*W));
    LD=[LD,ld];
    UD=[UD,ud];
end
ab1=UD              %%%加权正距离
ab2=LD              %%%加权负距离
%---------------------------------------------------获得两个模糊概念

X=ab1;
%X=ab2;
LIA1=[];
LIA2=[];
LIA3=[];


%%%%%%%%%-----------------------------------------------------求每个对象的6个损失函数
Q=0.3;
%------------------------------------------------------------------------------
MAX=max(X);    %%%%%%根据对象数量调整(最大值)
MIN=min(X);   %%%%%%根据对象数量调整（最小值）
%----------------------------------------------------计算每个概念的损失
SPP=zeros(1,m); 
SNN=zeros(1,m); 
SBP= Q*(X-MIN);
SNP=X-MIN;
SPN=MAX-X;
SBN= Q*(MAX-X);


%%%%%%%%%%%求类
FN=X;
NC=[];
for a7=1:m
    NCC=[];
    for a8=1:m
        if FN(1,a7)<=FN(1,a8)          %%%%%%%%%%(调整值)
            ncc=1;
        else
            ncc=0;
        end
        NCC=[NCC,ncc];
    end
    NC=[NC;NCC];                  
end
NC
%---------------------------NC；横向看，是每个对象的劣势类；纵向看，是每个对象的优势类


%-------------------------------------------------------------------------------------------条件概率
%----------------------------------- 计算条件概率（模糊条件下的概率计算公式）
NCX=[];
for a10=1:m
    ncx=NC(a10,:).*X;
    NCX=[NCX;ncx];
end
CPC=sum(NCX');
CP=[];
for a11=1:m
    cp=CPC(1,a11)./(sum(NC(a11,:)));
    CP=[CP,cp];            %%%%%%%条件概率
end

%%%-------------------------------------------- 计算阈值
T1=(SPN-SBN)./((SPN-SBN)+(SBP-SPP))   %%%%%阿尔法
T2=(SPN-SNN)./((SPN-SNN)+(SNP-SPP))   %%%%%伽玛
T3=(SBN-SNN)./((SBN-SNN)+(SNP-SBP))   %%%%%贝塔

%%%--------------------------------. 求三个域和决策规则（模糊决策理论粗糙集）
DOM1=[];  %正域
DOM2=[];  %边界域
DOM3=[];  %负域
for a12=1:m
    if CP(1,a12)>=T1(1,a12)
        pos=1;
    else
       pos=0;
    end
    DOM1=[DOM1,pos];
end
for a13=1:m
    if T3(1,a13)<=CP(1,a13) && CP(1,a13)<=T1(1,a13)
        bnd=1;
    else
        bnd=0;
    end
   DOM2=[DOM2,bnd];
end
for a14=1:m
    if CP(1,a14)<=T3(1,a14)
        neg=1;
    else
        neg=0;
    end
    DOM3=[DOM3,neg];
end

%%----------------------------------------- 排序
DOM1
DOM2
DOM3
RRR1=[T1;T2;T3];
[RR1,PP1]=size(RRR1);
pr1=[];
for ip=1:RR1
    RRR=RRR1(ip,:);
    [mn,nm]=sort(RRR,'descend');
pr1=[pr1;nm];
end
pr1


    

%------------------------正理想距离的排序
[mn1,nm1]=sort(ab1);
nm1
%------------------------负理想距离的排序
[mn2,nm2]=sort(ab2,'descend');
nm2



rrr=[T1;T2;T3];
end




