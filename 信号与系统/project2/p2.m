%------------------ Project 2 ----------------------
%----- Echo Cancellation via Inverse Filtering -----
%----- Written by Huang Qibin, 2023/5/18 -----------
%---------------------------------------------------
% Basic Problems
% (a)
n = (0:999)/1000;
H = 1+0.5*exp(-n*1000i);  
he = ifft(H);
figure(1);
subplot(1,2,1);
plot(H);
title('$H(e^{jw})$', 'Interpreter','latex');xlabel('Re(H)');ylabel('Im(H)');
subplot(1,2,2);
plot(real(he));
title('$he[n]$ (impulse signal)', 'Interpreter','latex');
axis([-50 1000 -0.7 1.2]);xlabel('n');ylabel('h');

% (b)
% 实际上是，但由于精度限制在工程上不成立；另一方面误差在10^-16，可以接受。
Hb = H.*(1./H);
figure(2);
subplot(1,2,1);
plot(Hb);
title('$H*(1/H)$ in Matlab', 'Interpreter','latex');
hb = ifft(Hb);
h0 = [1 zeros(1,999)];
e = (hb-h0)./hb;
subplot(1,2,2);
plot(e);
title('relative error');
xlim([-100 1100]);

% Intermediate Problems
% (c)
d = [1 zeros(1,4000)];
b = 1; a = [1 zeros(1,998) 0.5];
her = filter(b,a,d);
figure(3);plot(real(her));
title('her');
xlim([-200 4200]);

% (d)
load('lineup.mat');
Fs = 8192;
z = filter(1,a,y);
% sound([z ;zeros(3000,1); y] ,Fs);
figure(4);
subplot(1,2,1);plot(y);title('y');
subplot(1,2,2);plot(z);title('z');
dz = (z-y)./y;
figure(5);plot(dz);title('直观呈现z,y的区别')

% (e)
hoa = conv(he,her);
figure(6);plot(real(hoa));title('result');
% 计算机数据存储位数有限，精度不够

% Advanced Problems
% (f) 
% 太抽象了，给的实例有问题，列向量反转以后是不变的，我说Rxx怎么不是对称的。

%Estimate N and alpha
load('lineup.mat');
z = z.'; y2 = y2.'; y3 = y3.';
Rxx=conv(z,fliplr(z));
Ryy1 = conv(y2,fliplr(y2));
%由对称性，只取单边进行处理；为了下标和公式对应，将零点单独存储。
Ryy1_0 = Ryy1(7000); Rxx_0 = Rxx(7000);
Ryy1 = Ryy1(7001:13999); Rxx = Rxx(7001:13999);
% 选取图像(不在零点附近的)最高峰,得N_hat1
figure(7);plot(Ryy1);title('$R_{YY1}[n](n>0)$','Interpreter','latex');
N_hat1 = 501;
alpha_hat = (abs(Ryy1_0/Rxx_0-1))^0.5;

%Estimate N1, N2, alpha1, alpha2
Ryy2 = conv(y3, fliplr(y3));
Ryy2_0 = Ryy2(7000);
Ryy2 = Ryy2(7001:13999);
% 选取图像的最高峰和次高峰,得N1，N2
figure(8);plot(Ryy2);title('$R_{YY2}[n](n>0)$','Interpreter','latex');
N1 = 751; N2 = 2253;
alpha1_hat = Ryy2(N1)/Rxx_0;
alpha2_hat = Ryy2(N2)/Rxx_0;
