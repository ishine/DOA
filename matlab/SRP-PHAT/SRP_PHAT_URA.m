%% SRP Estimate of Direction of Arrival at Microphone Array
% Estimate the direction of arrival of a signal using the SRP-PHAT
% algorithm. 
%%

% x = filter(Num,1,x0);
c = 340.0;

% XMOS circular microphone array radius
d = 0.0457;
%%
% more test audio file in ../../TestAudio/ folder
path = '../../TestAudio/respeaker/mic4/';
[s1,fs] = audioread([path,'����-2.wav']);
s5 = audioread([path,'����-3.wav']);
s4 = audioread([path,'����-4.wav']);
s2 = audioread([path,'����-5.wav']);
signal = [s1,s5,s4,s2];
%%
t = 0;

% minimal searching grid
step = 1;

P = zeros(1,length(0:step:360-step));
tic
h = waitbar(0,'Please wait...');
for i = 0:step:360-step
    % Delay-and-sum beamforming
    [ DS, x1] = DelaySumURA(signal,fs,256,256,128,d,i/180*pi);
    t = t+1;
    %beamformed output energy
    P(t) = DS'*DS;
    waitbar(i / length(step:360-step))
end
toc
close(h) 
[m,index] = max(P);
figure,plot(0:step:360-step,P/max(P))
(index)*step






