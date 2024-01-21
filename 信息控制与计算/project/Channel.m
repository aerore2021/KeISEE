function [OutCode] = Channel(InputCode)
% EbNo=0:10; %SNR
EbNo = 13;
msg=InputCode;
%BPSK调制
M=2;
%约束长度
L=7;
%卷积码生成多项式
trel=poly2trellis(L,[171 133]);
%Viterbi译码器回溯深度
tblen=8*L;

%卷积编码
msg1=convenc(msg,trel);
%BPSK调制
x1=pskmod(msg1,M);
%加入高斯白噪声，码率为1/2,减去3dB
y=awgn(x1,EbNo-3);
%硬判决
y1=pskdemod(y,M);
%Viterbi译码
y1=vitdec(y1,trel,tblen,'cont','hard');
%误比特率
[err,ber1]=biterr(y1(tblen+1:end),msg(1:end-tblen));
%软判决
y2=vitdec(real(y),trel,tblen,'cont','unquant');
%误比特率
[err,ber2]=biterr(y2(tblen+1:end),msg(1:end-tblen));
% %BPSK调制理论误比特率
% figure(2);
% ber=berawgn(EbNo,'psk',2,'nodiff');
% semilogy(EbNo,ber,'-ko',EbNo,ber1,'-k*',EbNo,ber2,'-k.');
% title('卷积码性能');
% xlabel('Eb/No');
% ylabel('误比特率');
% legend('BPSK理论误比特率','硬判决误比特率','软判决误比特率');
OutCode = vertcat(y2(tblen+1:end),y2(1:tblen));
end