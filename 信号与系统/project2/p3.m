%---------------------------- Project 2 -----------------------------
%-- Amplitude Modulation and the Continuous-Time Fourier Transform --
%-------------- Written by Huang Qibin, 2023/5/18 -------------------
%--------------------------------------------------------------------
clear;
load('ctftmod.mat');
%Basic Problems
%(a) 
z = [dash dash dot dot];
figure(1); plot(t,z);title('letter z');

%(b)
FR = freqs(bf, af);
figure(2); plot(real(FR)); title('frequency response');
% through the plot, we can confirm it's a low-pass filter.

%(c)
sys = tf(bf,af);
ydash = lsim(sys, dash, t(1:length(dash)));
ydot = lsim(sys, dot, t(1:length(dot)));
figure(3);
subplot(1,2,1); plot(t(1:length(dash)),ydash,t(1:length(dash)),dash);title('ydash');
subplot(1,2,2); plot(t(1:length(dot)),ydot,t(1:length(dot)),dot);title('ydot');

%(d)
y_dash_m = dash.*cos(2*pi*f1*t(1:length(dash))); 
figure(4);
subplot(1,2,1);plot(t(1:length(y_dash_m)), y_dash_m);
title('modulated signal $y(t)$', 'Interpreter','latex');
y_dash_m_o = lsim(sys, y_dash_m, t(1:length(y_dash_m)));
subplot(1,2,2); plot(1:length(y_dash_m_o), y_dash_m_o);
title('output signal $yo$', 'Interpreter','latex');
% you can see the amplitude is of 10^-3, the output energy is low. 

%(e)、(f)
y1 = x.*cos(2*pi*f1*t(1:length(x)));
y1_m = lsim(sys, y1, t(1:length(y1)));
y2 = x.*sin(2*pi*f2*t(1:length(x)));
y2_m = lsim(sys, y2, t(1:length(y2)));
y3 = x.*sin(2*pi*f1*t(1:length(x)));
y3_m = lsim(sys, y3, t(1:length(y3)));
figure(5);
subplot(2,2,1);plot(y1_m);title('$m_1=[- . .]$','Interpreter','latex');
subplot(2,2,2);plot(y2_m);title('$m_2=[. . .]$','Interpreter','latex');
subplot(2,2,3);plot(y3_m);title('$m_3=[. - - .]$','Interpreter','latex');
subplot(2,2,4);plot(x);title('mixed signal x');
% so the answer is 'DSP'.