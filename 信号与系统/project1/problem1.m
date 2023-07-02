%----------project 1 problem 1-----------
%----------------------------------------
% to run this file, you need to include 
% the "computer explorations toolbox"
%----------------------------------------

% 1. Making Continuous-Time Pole-Zero Diagrams
% (a)
%  (i)
b1 = [1 5];
a1 = [1 2 3];
zs1 = roots(b1);
ps1 = roots(a1);
figure(1);
plot(real(zs1),imag(zs1),'o');
hold on;
plot(real(ps1),imag(ps1),'x');
grid;
axis([-7 7 -7 7]);

%  (ii)
b2 = [2 5 12];
a2 = [1 2 10];
zs2 = roots(b2);
ps2 = roots(a2);
figure(2);
plot(real(zs2),imag(zs2),'o');
hold on;
plot(real(ps2),imag(ps2),'x');
grid;
axis([-4 4 -4 4]);

%  (iii)
b3 = [2 5 12];
a3 = [1 4 14 20];
zs3 = roots(b3);
ps3 = roots(a3);
figure(3);
plot(real(zs3),imag(zs3),'o');
hold on;
plot(real(ps3),imag(ps3),'x');
grid;
axis([-4 4 -4 4]);

% (b)
%  (i) Re[pole1]=Re[pole2]=-1, so it has the ROC of Re[s]>-1 

%  (ii) Re[pole1]=Re[pole2]=-1, so it has the ROC of Re[s]>-1 

%  (iii) Re[pole1]=Re[pole2]=-1, Re[pole3]=-2, so it has the ROC of Re[s]>-1

% (c)
%   H(s)=(s^2+2s+5)/(s-3)
b = [1 2 5];
a = [1 -3];
figure(4);
[ps, zs] = pzplot(b,a,3.5);

% 2. Making Discrete-Time Pole-Zero Diagrams
% (a)
b = [1 -1 0]; a = [1 3 2];
figure(5);
dpzplot(b,a);

% (b)
b = [1]; a = [1 1 0.5];
figure(6);
dpzplot(b,a);

% (c)
b = [1 0.5]; a = [1 -1.25 0.75 -0.125];
figure(7); dpzplot(b,a);

% written by: 3210104064 Huang Qibin
% 2023/4/29