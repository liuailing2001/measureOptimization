
clear all;close all;clc;  
%% 参数配置初始化  
CNT = 1000;%对于每组(K,M,N)，重复迭代次数  
N = 256;%信号x的长度  
Psi = eye(N);%x本身是稀疏的，定义稀疏矩阵为单位阵x=Psi*theta  
K_set = [4,12,20,28,36];%信号x的稀疏度集合 
%  K_set = [4,12,20] 
 start=25
     Percentage = zeros(length(K_set),N);%存储恢复成功概率  
%% 主循环，遍历每组(K,M,N)  
tic  
for kk = 1:length(K_set)  
    K = K_set(kk);%本次稀疏度  
%     M_set = K:5:N;%M没必要全部遍历，每隔5测试一个就可以了  
 M_set = start:5:N;%M没必要全部遍历，每隔5测试一个就可以了  :5:N;%M没必要全部遍历，每隔5测试一个就可以了  
    PercentageK = zeros(1,length(M_set));%存储此稀疏度K下不同M的恢复成功概率  
    for mm = 1:length(M_set)  
       M = M_set(mm);%本次观测值个数  
       P = 0;  
       for cnt = 1:CNT %每个观测值个数均运行CNT次  
            Index_K = randperm(N);  
            x = zeros(N,1);  
            x(Index_K(1:K)) = 5*randn(K,1);%x为K稀疏的，且位置是随机的                  
%             Phi = randn(M,N);%测量矩阵为高斯矩阵  
           Phi=BernoulliMtx(M,N);%贝努利测量矩阵
%            Phi=ToeplitzMtx(M,N);%托佩兹测量矩阵
%                d=ceil(M/2);
%            Phi=SparseRandomMtx(M,N,d);
%               [Phi]=QRMeasurefunction(Phi);
              [Phi]=SVDmeasurefunction(Phi);
%             [Q,R]=qr(Phi');
%             [a,b]=size(R);
%             for i=1:a
%                 for j=i:b
%                     if i~=j
%                         R(i,j)=0;
%                     end
%                 end
%             end
%             ymax=max(max(R));
%              for i=1:a
%                 for j=i:b
%                     if i==j
%                         R(i,j)=ymax;
%                     end
%                 end
%             end
%             Phi=R'*Q';
% %             Phi=Phi';
            A = Phi * Psi;%传感矩阵  
            y = Phi * x;%得到观测向量y  
%             theta = cs_omp(y,A,K);%恢复重构信号theta  
%              theta = CS_ROMP(y,A,K);
%              theta = CS_ROMP(y,A,K);
                theta=CS_gOMP(y,A,K);
%               theta = CS_CoSaMP(y,A,K);
            x_r = Psi * theta;% x=Psi * theta  
            if norm(x_r-x)<1e-6%如果残差小于1e-6则认为恢复成功  
                P = P + 1;  
            end  
       end  
       PercentageK(mm) = P/CNT*100;%计算恢复概率  
    end  
    Percentage(kk,1:length(M_set)) = PercentageK;  
end  
toc  
% save MtoPercentage1000CS_gOMP_TPMx_raQR %运行一次不容易，把变量全部存储下来  
save MtoPercentage1000CS_gOMP_TPMx_raSVD %运行一次不容易，把变量全部存储下来 
%% 绘图  
S = ['-ks';'-ko';'-kd';'-kv';'-k*'];  
% figure;  
for kk = 1:length(K_set)  
    K = K_set(kk);  
    M_set = K:5:N;  
    L_Mset = length(M_set);  
    plot(M_set,Percentage(kk,1:L_Mset),S(kk,:),'MarkerFaceColor','red','color',[1 0 0]);%绘出x的恢复信号  
    hold on;  
end  
hold off;  
xlim([0 256]);  
legend('K=4','K=12','K=20','K=28','K=36');  
xlabel('Number of measurements(M)');  
ylabel('Percentage recovered');  
title('Percentage of input signals recovered correctly(N=256)(Gaussian)');