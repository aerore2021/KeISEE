% Recording
Fs=44800;%
nBits=16;%
nChannel=1;%
time=20;%录制音频的时间，单位是秒
recObj = audiorecorder(Fs, nBits, nChannel);

disp('Start speaking.')
%开始录制声音
recordblocking(recObj, time);
disp('End of Recording.');

% 回放录音数据
play(recObj);

% 获取录音数据
myRecording = getaudiodata(recObj);

% 绘制录音数据波形
plot(myRecording);

%存储语音信号
filename = 'audiorecorder_data_1.wav'; 
audiowrite(filename, myRecording, Fs);

% down = audioread("down.wav");
% up = audioread("up.wav");
% left = audioread("left.wav"); right = audioread("right.wav");
% leftup = audioread("leftup.wav"); leftdown = audioread("leftdown.wav");
% rightup = audioread("rightup.wav"); rightdown = audioread("rightdown.wav");
% figure(1)
% subplot(4,2,1);
% plot(left);
% title("left");
% subplot(4,2,2);
% plot(right);
% title("right");
% subplot(4,2,3);
% plot(up);
% title("up");
% subplot(4,2,4);
% plot(down);
% title("down");
% subplot(4,2,5);
% plot(leftup);
% title("leftup");
% subplot(4,2,6);
% plot(leftdown);
% title("leftdown");
% subplot(4,2,7);
% plot(rightup);
% title("rightup");
% subplot(4,2,8);
% plot(rightdown);
% title("rightdown");