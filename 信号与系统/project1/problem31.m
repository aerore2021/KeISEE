%----------project 1 problem 3-----------
% 1. Use the Sounds in Matlab -----------
%----------------------------------------
% I use relative path to include the 
% audio, don't move it.
%----------------------------------------

% Exercise 1 && 2
bassdrum = audioread("Audio Files\bassdrum.wav");
bleeep = audioread("Audio Files\bleeep.wav");
castanets = audioread("Audio Files\castanets44m.wav");
hatclosed = audioread("Audio Files\hatclosed.wav");
mixed = audioread("Audio Files\mixed.wav");
snare = audioread("Audio Files\snare.wav");
Fs = 8000;
figure(1);title('Exercise 1 && 2');
bassdrum=bassdrum.';subplot(3,2,1);plot(bassdrum);title('bassdrum');
bleeep=bleeep.';subplot(3,2,2);plot(bleeep);title('bleeep');
castanets=castanets.';subplot(3,2,3);plot(castanets);title('castanets');
hatclosed=hatclosed.';subplot(3,2,4);plot(hatclosed);title('hatclosed');
mixed=mixed.';subplot(3,2,5);plot(mixed);title('mixed');
snare=snare.';subplot(3,2,6);plot(snare);title('snare');

% A. Time-reverse & Timescale
% Exercise 3 && 4
castanets_scaled = resample(castanets,2,4);
figure(2); title('Exercise 3 && 4');
subplot(1,2,1);
plot(castanets);title('origin');
subplot(1,2,2);
plot(castanets_scaled);title('scaled by 1/2');
% the reason why the pitch changes with speed: 
% because when a sound is speeded up, the gaps between
% the soundwaves become smaller, and this increases 
% the pitch of the sound when our ears pick it up.

% B. Fader -- Exercise 5
time = 0:0.01:1;
y = cos(time.*pi.*0.25);
figure(3); title('Exercise 5');
subplot(1,5,1);plot(fade(y,0));title('level=0');
subplot(1,5,2);plot(fade(y,1));title('level=1');
subplot(1,5,3);plot(fade(y,0.25));title('level=0.25');
subplot(1,5,4);plot(fade(y,-2));title('level=-2');
subplot(1,5,5);plot(fade(y,100));title('level=100');

% C. Repeater -- Exercise 6
C1 = repeat(bassdrum,3);
C2 = repeat(bassdrum,0);
C3 = repeat(bassdrum,-1);
% length of C1 = 12000, that of C2 and C3 = 4000.

% D. Delay -- Exercise 7
D1 = delay(castanets, 3, Fs);
D2 = delay(castanets, -2.25, Fs);
figure(4);title('Exercise 7');
subplot(1,3,1);plot(castanets);title('origin');
subplot(1,3,2);plot(D1);title('delay 3s');
subplot(1,3,3);plot(D2);title('delay -2.25s');

% E.Mixer --Exercise 8
E = mix(D1,castanets);
figure(5);title('Exercise 8');
subplot(1,2,1);plot(castanets);title('castanets');
subplot(1,2,2);plot(E);title('castanets mixing delayed 3s');

% written by: 3210104064 Huang Qibin
% 2023/4/29