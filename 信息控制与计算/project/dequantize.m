function [out] = dequantize(input, fs, N)
%%% input
% N: 量化bit
% infile: 输入声音信号
%%% output
% out: 量化后的信号,-2^(N-1)+1:2^(N-1)

q = (1-(-1))/(2^N-1);
out = q*input;

% 量化和原始信号对比
len = length(input);
ts = (0:len-1)/fs;
% figure(1);
% subplot(1,2,1);
% plot(ts, input, 'b');
% title('原始语音信号');
% xlabel('time(s)');ylabel('amplitude');
% subplot(1,2,2);
% restore = q*out;
% plot(ts, restore, 'r');
% title('量化语音信号');
% xlabel('time(s)');ylabel('amplitude');
end