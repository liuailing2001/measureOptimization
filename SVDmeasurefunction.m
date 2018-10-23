function  [SVDPhi]=SVDmeasurefunction(Phi)
% clear all;close all;
% Phi=[1 2 3 ;12 23 34 ;12 2 34 ;3 6 7];
t=4;
[M,N]=size(Phi);
MinDim=min(M,N);
[U,S,V]=svd(Phi);
H=ones(M,N);
AvS=sum(S(:))/MinDim;
j=length(S(S>AvS));
for i=1:j
    H(:,i)= H(:,i)*t;
end
H1=H;
Phi1=Phi.*H1;
[U1,S1,V1]=svd(Phi1);
A=ones(MinDim);
S1=eye(M,N);
Phi2=U1*S1*V1;
SVDPhi=Phi2;




