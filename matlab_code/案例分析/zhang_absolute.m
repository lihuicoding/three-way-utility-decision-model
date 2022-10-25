clc
close all
clear all
RTR=[125    256    6000    256    16    128
     29      8000    32000     32    8    32
    110	    5000	 5000    142	8    64
    25	    1310	2620	131	12	   24
    75	    2000	8000	8	3	  24
    140	    2000	32000	32	1   54
    26	    16000	32000	64	8   24
    160	   1000	    8000	16	1  	14];%%%行为对象，列为准则  
X=RTR;
[a,b]=size(X);
J = [2 1 1 1 1 1];
[m,n] = size(X);
% 1.Normalization
A = zeros(m,n);
for j = 1:n
	if J(j) == 1
       A(:,j) = X(:,j)./max(X(:,j));
  %A(:,j) = (X(:,j)-min(X(:,j)))./(max(X(:,j))-min(X(:,j)));
    else
        A(:,j) = min(X(:,j))./X(:,j);
   %A(:,j) = (max(X(:,j))-X(:,j))./(max(X(:,j))-min(X(:,j)));
	end    
end
TA=A 

[a,b]=size(RTR);
bbbb=[0.23 0.06 0.19 0.25 0.50 0.19];%h_j
cccc=1-bbbb%l_j

DOM1M=[];
DOM2M=[];
DOM3M=[];
PXX=[];
QQ=[0.3,0.32,0.34,0.36,0.38,0.4,0.42,0.44,0.46,0.48];
[aw,bw]=size(QQ);
for i=1:bw
Q=QQ(1,i);%rho
%-------------------------------------------------TOPSIS，获得模糊概念
W = [0.20,0.25,0.30,0.14,0.03,0.08];


 ba1=max(TA); %每一列最大值，正理想
 ba2=min(TA);%每一列最小值，负理想
 
% ap=0.4;
% bbbb=ap*ba1+(1-ap)*ba2;
%bbbb=sum(TA)/a

LD=[];
UD=[];
for aa1=1:a
    ld1=sum(max(0,TA(aa1,:)-bbbb(1,:)).*W);
    ud2=sum(max(0,bbbb(1,:)-TA(aa1,:)).*W);
    LD=[LD,ld1];
    UD=[UD,ud2];
end
ab1=LD              %%%加权状态损失,正理想
ab2=UD              %%%加权负状态损失，负理想

 SBP=Q*ab1; 
SNP=ab1; 
SPN=ab2; 
SBN=Q*ab2;
SPP=zeros(1,a); 
SNN=zeros(1,a); 
 
 
 
%----------------------------------- 计算条件概率（模糊条件下的概率计算公式）

% NCX1=[];
% for j=1:a
%     ncx1=TA(j,:).*bbbb;
%     NCX1=[NCX1;ncx1];
% end
% CPC1=sum(NCX1');
% CP1=[];
% for k=1:a
%     cp1=CPC1(1,k)./(sum(TA(k,:)));
%     CP1=[CP1,cp1];            %%%%%%%条件概率
% end
%CP1%每个对象关于综合理想解的概率



 B=bbbb;
[u,v]=size(B);
LB=[];
UB=[];
for q=1:a
    ILB=[];
    TUB=[];
    for p=1:u
        L=[];
        U=[];
        for n=v;s=1:b;
            DL=max(1-TA(q,s),B(p,s));
            DU=min(TA(q,s),B(p,s));
            L=[L;DL];
            U=[U;DU];
        end
        n1=min(L);
        n2=max(U);
        ILB=[ILB;n1];
        TUB=[TUB;n2];
    end
    ILB=ILB';
    TUB=TUB';
    LB=[LB;ILB];
    UB=[UB;TUB];
end
   CP1=LB' 
    %CP1=UB' 





%%%-------------------------------------------- 计算阈值
alpha=(SPN-SBN)./((SPN-SBN)+(SBP-SPP))   %%%%%阿尔法
gamma=(SPN-SNN)./((SPN-SNN)+(SNP-SPP))   %%%%%伽玛
beta=(SBN-SNN)./((SBN-SNN)+(SNP-SBP))   %%%%%贝塔
T1=alpha;
T2=gamma;
T3=beta;
%%%--------------------------------. 求三个域和决策规则（模糊决策理论粗糙集）
DOM1=[];  %正域
DOM2=[];  %边界域
DOM3=[];  %负域
for a12=1:a
    if CP1(1,a12)>=T1(1,a12)
        pos=1;
    else
       pos=0;
    end
    DOM1=[DOM1,pos];
end
for a13=1:a
    if T3(1,a13)<CP1(1,a13) && CP1(1,a13)<T1(1,a13)
        bnd=1;
    else
        bnd=0;
    end
   DOM2=[DOM2,bnd];
end
for a14=1:a
    if CP1(1,a14)<=T3(1,a14)
        neg=1;
    else
        neg=0;
    end
    DOM3=[DOM3,neg];
end

CCP=1-CP1;  %%%补概率（坏状态的概率）
RP=(SPP.*CP1+SPN.*CCP).*DOM1   %%%正域相关损失
RB=(SBP.*CP1+SBN.*CCP).*DOM2   %%%边界域相关损失
RN=(SNP.*CP1+SNN.*CCP).*DOM3   %%%负域相关损失
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%正域排序
AC11=[];
AC12=[];
for a15=1:a;
    if RP(1,a15)>0;
        ac1=a15;
        rp=RP(1,ac1);
    else
        ac1=[];
         rp=[];
    end
    AC11=[AC11,ac1];
    AC12=[AC12,rp];
end
[PXP1,PXP2]=sort(AC12);
[XP1,XP2]=size(PXP2);   
PX1=[];
for a16=1:XP2;
    px1=AC11(1,PXP2(1,a16));
PX1=[PX1,px1];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%边界域排序
AC21=[];
AC22=[];
for a17=1:a;
    if RB(1,a17)>0;
        ac2=a17;
        rb=RB(1,ac2);
    else
        ac2=[];
         rb=[];
    end
    AC21=[AC21,ac2];
    AC22=[AC22,rb];
end
[PXB1,PXB2]=sort(AC22);
[XB1,XB2]=size(PXB2);   
PX2=[];
for a18=1:XB2;
    px2=AC21(1,PXB2(1,a18));
PX2=[PX2,px2];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%负域排序
AC31=[];
AC32=[];
for a19=1:a;
    if RN(1,a19)>0;
        ac3=a19;
        rn=RN(1,ac3);
    else
        ac3=[];
         rn=[];
    end
    AC31=[AC31,ac3];
    AC32=[AC32,rn];
end
[PXN1,PXN2]=sort(AC32);
[XN1,XN2]=size(PXN2);   
PX3=[];
for a20=1:XN2;
    px3=AC31(1,PXN2(1,a20));
PX3=[PX3,px3];
end
PX=[PX1 PX2 PX3];        %%%%%%%%%%%%%%%%总排序
 
DOM1M=[DOM1M;DOM1];  %正域
DOM2M=[DOM2M;DOM2];   %边界域
DOM3M=[DOM3M;DOM3];   %负域
PXX=[PXX;PX];
end
DOM1M 
DOM2M 
DOM3M 
PXX
