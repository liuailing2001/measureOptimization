function [ theta ] = CS_gOMP( y,A,K,S )  
%CS_gOMP Summary of this function goes here  
%Version: 1.0 written by jbb0523 @2015-05-08  
%   Detailed explanation goes here  
%   y = Phi * x  
%   x = Psi * theta  
%   y = Phi*Psi * theta  
%   令 A = Phi*Psi, 则y=A*theta  
%   现在已知y和A，求theta  
%   Reference: Jian Wang, Seokbeop Kwon, Byonghyo Shim.  Generalized   
%   orthogonal matching pursuit, IEEE Transactions on Signal Processing,   
%   vol. 60, no. 12, pp. 6202-6216, Dec. 2012.   
%   Available at: http://islab.snu.ac.kr/paper/tsp_gOMP.pdf  
    if nargin < 4  
        S = round(max(K/4, 1));  
    end  
    [y_rows,y_columns] = size(y);  
    if y_rows<y_columns  
        y = y';%y should be a column vector  
    end  
    [M,N] = size(A);%传感矩阵A为M*N矩阵  
    theta = zeros(N,1);%用来存储恢复的theta(列向量)  
    Pos_theta = [];%用来迭代过程中存储A被选择的列序号  
    r_n = y;%初始化残差(residual)为y  
    for ii=1:K%迭代K次，K为稀疏度  
        product = A'*r_n;%传感矩阵A各列与残差的内积  
        [val,pos]=sort(abs(product),'descend');%降序排列  
        Sk = union(Pos_theta,pos(1:S));%选出最大的S个  
        if length(Sk)==length(Pos_theta)  
            if ii == 1  
                theta_ls = 0;  
            end  
            break;  
        end  
        if length(Sk)>M  
            if ii == 1  
                theta_ls = 0;  
            end  
            break;  
        end  
        At = A(:,Sk);%将A的这几列组成矩阵At  
        %y=At*theta，以下求theta的最小二乘解(Least Square)  
        theta_ls = (At'*At)^(-1)*At'*y;%最小二乘解  
        %At*theta_ls是y在At)列空间上的正交投影  
        r_n = y - At*theta_ls;%更新残差  
        Pos_theta = Sk;  
        if norm(r_n)<1e-6  
            break;%quit the iteration  
        end  
    end  
    theta(Pos_theta)=theta_ls;%恢复出的theta  
end  