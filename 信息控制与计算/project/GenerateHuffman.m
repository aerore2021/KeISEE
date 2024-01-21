function [dict, avglen, Entropy_s, Rate, MFCC_feature] = GenerateHuffman(Fs, N)
down = audioread("down.wav");
up = audioread("up.wav");
left = audioread("left.wav"); right = audioread("right.wav");
leftup = audioread("leftup.wav"); leftdown = audioread("leftdown.wav");
rightup = audioread("rightup.wav"); rightdown = audioread("rightdown.wav");
% Fs = 44800; N = 5;

% 归一化
down = down/max(abs(down));up = up/max(abs(up));
right = right/max(abs(right));left = left/max(abs(left));
leftup = leftup/max(abs(leftup));leftdown = leftdown/max(abs(leftdown));
rightup = rightup/max(abs(rightup));rightdown = rightdown/max(abs(rightdown));

% 量化
res = 2/2^N;
Down = quantize(down, Fs, N); Up = quantize(up, Fs, N);
Left = quantize(left, Fs, N); Right = quantiz(right, Fs, N);
LeftDown = quantize(leftdown, Fs, N); RightUp = quantize(rightup, Fs, N);
RightDown = quantize(rightdown, Fs, N); LeftUp = quantize(leftup, Fs, N);

% 信源编码
prob = [];
len = [];
Len = length(Down)*8;
%% 得到概率
for i=1:1:2^N
    len(i)=length(find(Down==(i-16)))+length(find(Up==(i-16)))+length(find(Left==(i-16)))+length(find(Right==(i-16)))+length(find(LeftUp==(i-16)))+length(find(LeftDown==(i-16)))+length(find(RightDown==(i-16)))+length(find(RightUp==(i-16)));
    prob(i)=len(i)/Len;
end

%% Huffman编码
[dict, avglen] = huffmandict((-15:16),prob);

Entropy_s = entropy(prob);
Rate = N/avglen-1;

%% Generate MFCC features

MFCC_feature = {mfcc(down, Fs);mfcc(up, Fs);mfcc(rightdown, Fs);mfcc(rightup, Fs);mfcc(leftdown, Fs);mfcc(leftup, Fs);mfcc(right, Fs);mfcc(left, Fs)};

end