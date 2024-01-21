% clear; 
% Fs = 44800; N = 5;
%  InputAudio = audioread("input.wav");
% [dict, avglen, Entropy_Source, PressRate, MFCC] = GenerateHuffman(Fs, N);
% fprintf('avglen:%f\nEntropy:%f\nPress Rate:%f\n',avglen,Entropy_Source,PressRate);
% 
% InputAudio = InputAudio/(max(abs(InputAudio)));
% InputAudio_q = quantize(InputAudio, Fs, N);
% InputCode = huffmanenco(InputAudio_q,dict);
% OutCode = Channel(InputCode);
% OutAudio_q = huffmandeco(OutCode, dict);
% % 计算误码率
% % Error = length(OutAudio_q)-length(find(OutAudio_q-InputAudio_q==0));
% RebuildAudio = dequantize(OutAudio_q, Fs, N);
% % 信号重建对比
% % figure(1);
% % subplot(1,2,1);
% % plot(InputAudio);
% % title('Original Audio');
% % subplot(1,2,2);
% % plot(RebuildAudio);
% % title('Reconstruction of Audio');
% for i=1:10
%     res(i) = Compare(MFCC, mfcc(RebuildAudio((i-1)*2*Fs+1:i*2*Fs),Fs));
% end
% ydig = [1 3 5 8 1 2 4 6 7 5];% 左 上 左上 右下 左 右 下 左下 右上 左上 
A =  {[0,0] [-1,0] [-2,1] [-1,0] [-2,0] [-3,0] [-3,1] [-3,2] [-4,1]};

line([0 -1],[0,0]);
hold on;
line([-1 -2],[0,1]);
hold on;
line([-2 -1],[1,0]);
hold on;
line([-1 -2],[0,0]);
hold on;
line([-2 -3],[0,0]);
hold on;
line([-3 -3],[0,1]);
hold on;
line([-3 -3],[1,2]);
hold on;
line([-3 -4],[2,1]);