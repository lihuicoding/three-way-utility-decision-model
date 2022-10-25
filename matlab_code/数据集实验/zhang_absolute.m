function [PX5_jue,f_DOM1_jue,f_DOM2_jue,f_DOM3_jue,juedui_POS,juedui_NEG]=lunwen5_jue(TA,W,H,Q)
 
[a,b]=size(TA);
%TTTT=sum(A)./8
bbbb=H;
%bbbb=[ 0.73    0.67    0.55     0.83    0.41     0.35    0.45     0.68];%h_j
cccc=1-bbbb;%l_j
%Q=0.3;%rho
%------------------------------------------------- 
%W=[0.15,0.2,0.05,0.1,0.15,0.1,0.1,0.15];

% FF=RTR*W;
% FFF=bbbb*W';
% FFFF=cccc*W';

 ba1=max(TA); %ÿһ�����ֵ��������
 ba2=min(TA);%ÿһ����Сֵ��������
 
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
ab1=LD;              %%%��Ȩ״̬��ʧ,������
ab2=UD;              %%%��Ȩ��״̬��ʧ��������

 SBP=Q*ab1; 
SNP=ab1; 
SPN=ab2; 
SBN=Q*ab2;
SPP=zeros(1,a); 
SNN=zeros(1,a);
 
%----------------------------------- �����������ʣ�ģ�������µĸ��ʼ��㹫ʽ��

% NCX1=[];
% for j=1:a
%     ncx1=TA(j,:).*bbbb;
%     NCX1=[NCX1;ncx1];
% end
% CPC1=sum(NCX1');
% CP1=[];
% for k=1:a
%     cp1=CPC1(1,k)./(sum(TA(k,:)));
%     CP1=[CP1,cp1];            %%%%%%%��������
% end
%CP1%ÿ����������ۺ������ĸ���



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
   CP1=LB'; 
   % CP1=UB' 





%%%-------------------------------------------- ������ֵ
alpha=(SPN-SBN)./((SPN-SBN)+(SBP-SPP));   %%%%%������
gamma=(SPN-SNN)./((SPN-SNN)+(SNP-SPP));   %%%%%٤��
beta=(SBN-SNN)./((SBN-SNN)+(SNP-SBP));   %%%%%����
T1=alpha;
T2=gamma;
T3=beta;
%%%--------------------------------. ��������;��߹���ģ���������۴ֲڼ���
DOM1=[];  %����
DOM2=[];  %�߽���
DOM3=[];  %����
for a12=1:a
    if T1(1,a12)==0 && T3(1,a12)==0
        pos=1;
    else if T1(1,a12)==1 && T3(1,a12)==1
        pos=0;
        else if CP1(1,a12)>=T1(1,a12)
        pos=1;
            else
        pos=0;
            end
        end
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
    if T1(1,a14)==0 && T3(1,a14)==0
        neg=0;
    else if T1(1,a14)==1 && T3(1,a14)==1
        neg=1;
        else if CP1(1,a14)<=T3(1,a14)
        neg=1;
            else
        neg=0;
            end
        end
    end
    DOM3=[DOM3,neg];
end

CCP=1-CP1;  %%%�����ʣ���״̬�ĸ��ʣ�
RP=(SPP.*CP1+SPN.*CCP).*DOM1;   %%%���������ʧ
RB=(SBP.*CP1+SBN.*CCP).*DOM2;   %%%�߽��������ʧ
RN=(SNP.*CP1+SNN.*CCP).*DOM3;   %%%���������ʧ

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������

P_O1=find(DOM1==1);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�����еĶ����λ��
P_O2=RP(:,P_O1);   % ��ȡ�����еĶ�������Ӧ�������ʧ
P_O2_0=find(P_O2==0);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�����еĶ����������ʧΪ0��λ��
P_O2_00=P_O1(:,P_O2_0);   % ��ȡ������ʧΪ0��λ��
juedui_POS=length(P_O2_00);
[P_O3,P_O4]=sort(P_O2);
P_X1=[];
for a_P=1:length(P_O4) 
    P_x1=P_O1(1,P_O4(1,a_P));
    P_X1=[P_X1,P_x1];
end
P_X1;

 
B_O1=find(DOM2==1);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�߽����еĶ����λ��
B_O2=RB(:,B_O1);   % ��ȡ�߽����еĶ�������Ӧ�������ʧ
B_O2_0=find(B_O2==0);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�߽����еĶ����������ʧΪ0��λ��
B_O2_00=B_O1(:,B_O2_0);    % ��ȡ������ʧΪ0��λ��
[B_O3,B_O4]=sort(B_O2);
B_X1=[];
for a_B=1:length(B_O4) 
    B_x1=B_O1(1,B_O4(1,a_B));
    B_X1=[B_X1,B_x1];
end
B_X1;




N_O1=find(DOM3==1);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�����еĶ����λ��
N_O2=RN(:,N_O1);   % ��ȡ�����еĶ�������Ӧ�������ʧ
N_O2_0=find(N_O2==0);  %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�����еĶ����������ʧΪ0��λ��
N_O2_00=N_O1(:,N_O2_0);   % ��ȡ������ʧΪ0��λ��
juedui_NEG=length(N_O2_00);
[N_O3,N_O4]=sort(N_O2);
N_X1=[];
for a_N=1:length(N_O4) 
    N_x1=N_O1(1,N_O4(1,a_N));
    N_X1=[N_X1,N_x1];
end
N_X1;

 
PX=[P_X1 B_X1 N_X1];        %%%%%%%%%%%%%%%%������

DOM1;  %����
f_DOM1_jue=find(DOM1==1);    %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽz���еĶ����λ��
DOM2;   %�߽���
f_DOM2_jue=find(DOM2==1);    %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽb���еĶ����λ��
DOM3;   %����
f_DOM3_jue=find(DOM3==1);    %%%%%%%%%%%%%%%%%%%%%%%%%%���ൽ�����еĶ����λ��
PX5_jue=PX;
end

