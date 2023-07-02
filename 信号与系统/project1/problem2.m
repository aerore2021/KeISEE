%----------project 1 problem 2--------------
%-------------------------------------------
% 1. to run this file, you need to include 
%    the "computer explorations toolbox".
% 2. I use relative path to include the 
%    image, plz don't move it in the folder.
%-------------------------------------------

%(a)
% p[n]=1, -1, -1, 0, 0, ...
% and when p[-1] = 1, we can let y[n] has maxima at points 
% that are centered on the desired pattern(n=2).

%(b)
A = imread("findsmiley.jpg");
% normalization
A = double(A/128)-1;
P = [
 1  1  1  1  1  1  1;
 1 -1 -1 -1 -1 -1  1;
 1 -1  1  1  1 -1  1;
 1 -1 -1 -1 -1 -1  1;
 1 -1 -1  1 -1 -1  1;
 1 -1  1 -1  1 -1  1;
 1 -1 -1 -1 -1 -1  1;
 1  1  1  1  1  1  1;
];
B = conv2(A,P);
% to ensure maximun of B equals to 56
m = max(max(B)); 
[x,y]=find(B==max(max(B)));

%(c)
R = normrnd(0,1,[1024 1024]);
Ar = A + R;
Br = conv2(Ar, P);
mr = max(max(Br)); 
[xr,yr]=find(Br==max(max(Br)));

% written by: 3210104064 Huang Qibin
% 2023/4/29