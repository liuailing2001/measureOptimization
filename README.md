# measureOptimization
Measurement matrix optimization method based on hybrid matrix decomposition
1   The experimental sample is a one-dimensional signal generated randomly at a length of N=256.
2    Fig. 1 data：f1(a)_OMP_Guassian.mat，f1(b)_gOMP_Guassian.mat，f1(c)_ROMP_Guassian.mat
      Fig.2 data: f2(a)_OMP_BM.mat,  f2(b)_OMP_BM.mat,  f2(c)_OMP_BM.mat
      Fig.3  data：f3(a)_OMP_TP.mat，f3(b)_ROMP_TP.mat， f3(c)_ROMP_TP.mat 
3    Fig.4 data：TwoDimImge_f4(f).mat
4    Source upload : 
CS_OMP ------ Orthogonal Matching Algorithm. 
CS_gOMP--------- Segmented Orthogonal Matching Pursuit.
CS_ROMP------- Regularized Orthogonal Matching Pursuit.
GaussMtx-------------Gassian Measure Matrix.
BernoulliMtx---------Bernoulli  Measure Matrix.
ToeplitzMtx----------Toeplitz    Measure Matrix.
QRMeasurefunction------- QR decomposition measurement matrix optimization.
SVDmeasurefunction------ SVD decomposition measurement matrix optimization.
DemoMain------------Main function.
