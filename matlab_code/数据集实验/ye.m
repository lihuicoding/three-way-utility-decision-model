clc
close all
clear all
% RTR=[7.5    52100000    20000000    2179    3743181    16782    565    9224
%      4      15800000    7000000     2544    1844690    3728     581    9536
%     6.5	    71500000	 9000000    2805	1142295    3895	    193	   49424
%     5.8	    38900000	13000000	3230	1488038	   2571	    553	   88586
%     3.1	    14000000	16000000	1825	5611593	   11187	2111   116800
%     7.2	    76100000	55000000	3303	2028767	   3829	    500	   124000
%     6.5	    26000000	28000000	2714	2213659	    2210	419	   125646
%     7.1	   36400000	    25000000	3019	1470438  	4314	168	  130000];%%%��Ϊ������Ϊ׼��  
% RTR=[125    256    6000    256    16    128
%      29      8000    32000     32    8    32
%     110	    5000	 5000    142	8    64
%     25	    1310	2620	131	12	   24
%     75	    2000	8000	8	3	  24
%     140	    2000	32000	32	1   54
%     26	    16000	32000	64	8   24
%     160	   1000	    8000	16	1  	14];%%%��Ϊ������Ϊ׼��  
% X=RTR;
% [a,b]=size(X);
% % J = [1 1 2 1 1 1 2 1];
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
% X=xlsread('C:\Users\���\Desktop\ASOC-D-22-02636\������ݼ�\tripadvisor_review','B2:K981');
% % J = [2 1 2 1];
% J = [1 1 1 1 1 1 1 1 1 1]

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

[a,b] = size(X);
A=zeros(a,b);
for j = 1:b
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

%-------------------------------------------------TOPSIS�����ģ������
% W=[0.15,0.2,0.05,0.1,0.15,0.1,0.1,0.15];
% W = [0.20,0.25,0.30,0.14,0.03,0.08];
W = ones(1,b).*(1/b);
%%%%%%%%%��ÿ�������6����ʧ����
% Q=[0.3 0.3 0.3 0.3 0.3 0.3 0.3  0.3];
% Q=[0.3 0.3 0.3 0.3 0.3 0.3]
Q = ones(1,b).*0.3;

MAX= ones(1,b);    %%%%%%����׼�����(���ֵ)
MIN= zeros(1,b);    %%%%%%����׼���������Сֵ��
SPP= zeros(1,a); 
SNN= zeros(1,a);
SBP=[];
SNP=[];
SPN=[];
SBN=[];
for a3=1:a;
sbp=sum(W.*Q.*(TA(a3,:)-MIN));
snp=sum(W.*(TA(a3,:)-MIN));
spn=sum(W.*(MAX-TA(a3,:)));
sbn=sum(W.*Q.*(MAX-TA(a3,:)));
SBP=[SBP,sbp];
SNP=[SNP,snp];
SPN=[SPN,spn];
SBN=[SBN,sbn];
end
%%%%%%%%%%%%%%Step1  ............  ����ģ��������
%%%%%%%%%%%%%%%%%%%    ��������������������
p=0.5;   %%%ģ��������ֵ   ������ֵ��
q=0.7;   %%%ģ��������ֵ   ������ֵ��
%%%%%%%%%%%����С����
M=[];
for a4=1:a;
md=[];
for b5=1:b;
bn=[];
for b6=1:b;
if TA(a4,b6)>=p & TA(a4,b5)>=p & TA(:,b6)>=TA(:,b5);
   bn1=1;
else if TA(a4,b6)<p;
   bn1=0;
else
  bn1=0;
end
end
bn=[bn;bn1];
end
md=[md,bn];
end
M=[M;md];
end
%%%%%%%%%%%���ݶ����������         (������Ϊ����)
M11=M(1:b,:);
M22=M(b+1:2.*b,:);

MMM = []
for i=3:a;
   MMM = [MMM;M((i-1).*b+1:i.*b,:)];
end

% M33=M(2.*b+1:3.*b,:);
% M44=M(3.*b+1:4.*b,:);
% M55=M(4.*b+1:5.*b,:);
% M66=M(5.*b+1:6.*b,:);
% M77=M(6.*b+1:7.*b,:);
% M88=M(7.*b+1:8.*b,:);
%%%%%%%%%%����С����,���ݶ��������������������
[c,d]=size(M11)
Md11=[];
for c1=1:c;
if sum(M11(c1,:))==1;
  md11=c1;
     else
  md11=0;
end
Md11=[Md11,md11];
end
Md22=[];
for c1=1:c;
if sum(M22(c1,:))==1;
  md22=c1;
     else
  md22=0;
end
Md22=[Md22,md22];
end

result = []
for i=1:a-2;
Mdm = []
for c1=1:c;
temp = MMM((i-1).*b+1:i.*b,:);
if sum(temp(c1,:))==1;
    mdm=c1;
     else
    mdm=0;
end
Mdm=[Mdm,mdm];
end
result = [result;Mdm];
end

% Md33=[];
% for c1=1:c;
% if sum(M33(c1,:))==1;
%   md33=c1;
%      else
%   md33=0;
% end
% Md33=[Md33,md33];
% end
% Md44=[];
% for c1=1:c;
% if sum(M44(c1,:))==1;
%   md44=c1;
%      else
%   md44=0;
% end
% Md44=[Md44,md44];
% end
% Md55=[];
% for c1=1:c;
% if sum(M55(c1,:))==1;
%   md55=c1;
%      else
%   md55=0;
% end
% Md55=[Md55,md55];
% end
% Md66=[];
% for c1=1:c;
% if sum(M66(c1,:))==1;
%   md66=c1;
%      else
%   md66=0;
% end
% Md66=[Md66,md66];
% end
% Md77=[];
% for c1=1:c;
% if sum(M77(c1,:))==1;
%   md77=c1;
%      else
%   md77=0;
% end
% Md77=[Md77,md77];
% end
% Md88=[];
% for c1=1:c;
% if sum(M88(c1,:))==1;
%   md88=c1;
%      else
%   md88=0;
% end
% Md88=[Md88,md88];
% end
% MD=[Md11; Md22; Md33; Md44; Md55; Md66; Md77; Md88];   %%%���ݶ������������Ϊ�ܵĶ������������С��������������
MD=[Md11; Md22; result];   %%%���ݶ������������Ϊ�ܵĶ������������С��������������
%%%%%%%%%%%%%%%%%������
NNN=[];  %%%����
for a5=1:a;
NN=[];
for a6=1:a;
N=[];
for b7=1:b;
    if MD(a5,b7)==0
        fn=1;
    else
        fn=min(1,1-TA(a5,b7)+TA(a6,b7));
    end
N=[N,fn];
end
fnn=min(N);
NN=[NN,fnn];
end
NNN=[NNN;NN];  %%%%%%%%%%ģ����������
end
%%%%%%%%%%%��������
FN=NNN
NC=[];
for a7=1:a;
    NCC=[];
    for a8=1:a;
        if FN(a7,a8)>=q;           %%%%%%%%%%(����ֵ)
            ncc=1;
        else
            ncc=0;
        end
        NCC=[NCC,ncc];
    end
    NC=[NC;NCC];                 %%%���У�ÿ��Ϊ1�Ķ�Ӧ����Ϊ�������Ԫ�أ�ģ�������ࣩ
end
%%%%%%%%%%%Step2 ............ ����״̬�����õ�״̬��
WA=[];
for a9=1:a;
  wa=TA(a9,:) .*W;
  WA=[WA;wa];
end
X=sum(WA')   %%%%%�õ�״̬
%X=1-X
%%%%%%%%%%Step3 ............. �����������ʣ�ģ�������µĸ��ʼ��㹫ʽ��
NCX=[];
for a10=1:a;
    ncx=NC(a10,:).*X
    NCX=[NCX;ncx];
end
CPC=sum(NCX');
CP=[];
for a11=1:a;
    cp=CPC(1,a11)./(sum(NC(a11,:)));
    CP=[CP,cp];            %%%%%%%��������
end
%%%%%%%%%%%Step4 ............... ������ֵ
T1=(SPN-SBN)./((SPN-SBN)+(SBP-SPP))   %%%%%������
T2=(SPN-SNN)./((SPN-SNN)+(SNP-SPP))   %%%%%٤��
T3=(SBN-SNN)./((SBN-SNN)+(SNP-SBP))   %%%%%����
%%%%%%%%%%Step5 ................. ��������;��߹���ģ���������۴ֲڼ���
DOM1=[];  %����
DOM2=[];  %�߽���
DOM3=[];  %����
for a12=1:a;
    if CP(1,a12)>=T1(1,a12);
        pos=1;
    else
       pos=0;
    end
    DOM1=[DOM1,pos];
end
for a13=1:a;
    if T3(1,a13)<=CP(1,a13) & CP(1,a13)<=T1(1,a13);
        bnd=1;
    else
        bnd=0;
    end
   DOM2=[DOM2,bnd];
end
for a14=1:a;
    if CP(1,a14)<=T3(1,a14);
        neg=1;
    else
        neg=0;
    end
    DOM3=[DOM3,neg];
end
%%%%%%%%%%%Step6 ..................... �����ʧ������
CCP=1-CP;  %%%�����ʣ���״̬�ĸ��ʣ�
RP=(SPP.*CP+SPN.*CCP).*DOM1;  %%%���������ʧ
RB=(SBP.*CP+SBN.*CCP).*DOM2;  %%%�߽��������ʧ
RN=(SNP.*CP+SNN.*CCP).*DOM3;  %%%���������ʧ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�߽�������
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������
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
PX=[PX1 PX2 PX3]        %%%%%%%%%%%%%%%%������

disp(DOM1)
disp(DOM2)
disp(DOM3)

data = PX;
writematrix(data,'winequality_white_ye_ranking_result.csv');     % д��csv
% writematrix(data,'winequality_red_ye_ranking_result.csv');     % д��csv
% writematrix(data,'tripadvisor_review_ye_ranking_result.csv');     % д��csv
% writematrix(data,'CSM_ye_ranking_result.csv');     % д��csv
% writematrix(data,'concrete_ye_ranking_result.csv');     % д��csv
