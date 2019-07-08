%% This is literally just copied from Beverly's Behavior analysis 


%     Don't forget to add chronux to path in order for spectrogram to work
%     Use similar format in your own script 
%addpath chronux_2_12_2      %doesn't work so will need to add path
%                               manually, doesn't like the space


%% Load to path of the EEG data and load to path of the hdr file


subject  = 'osceeg22b';
run = 'run01';
folder = 'osceeg_frommgh/'; %'inkrefcap/';

path = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subject];
tosave = 1;
%% Find behavior arousal time

load([ path,'/behav/', run,'_clicktimes.mat'])
x = ones(length(clicktimes),1);
figure();plot(clicktimes, x, '*')
title('Click Times')
%% load EEG 
%EEG data 
path1 = [path, '/eeg/fs200_averef_regbcg/', run, '/c126'];
load(path1)
EEG = ch;

path2 = [path, '/eeg/fs200_averef_regbcg/', run, '/hdr'];
load(path2)

timeEEG = hdr.ts;
timeMRI = hdr.trs;

%% Interclick intervals
%take difference between click rates y(n+1)- y(n)
xn1 = [clicktimes; 0];
xn = [0; clicktimes];
clickinterval= xn1-xn;
clickinterval=clickinterval(2:end-1);

% figure();gcf = plot(clicktimes(2:end), clickinterval, '*');
% title('Interclick interval')
% xlabel('Click time (s)'); ylabel('time since previous click (s)')

[lengthSleep, arous] = max(clickinterval); %finding max delay between clicks
arousTime = clicktimes(arous+1); %time that corresponds to max
%arousTime = 3167.3; 17b run01
%arousTime = 1192.3; 15b run03

%take 50 seconds before and after arousal click
range = 30;
timeStart = arousTime - range;
timeEnd = arousTime + range;

smallRange = 3;
timeStar = arousTime - smallRange;
timeEn = arousTime +smallRange

%extract all clicks in range 
arousClickTime = clicktimes(find((clicktimes>timeStart) & (clicktimes<timeEnd)));
arousClicks = ones(length(arousClickTime));
%% extracting arousal period

arousTimeInd = find((timeEEG > timeStart) & (timeEEG < timeEnd));
arousTimeEEG = timeEEG(arousTimeInd);
arousEEG = EEG(arousTimeInd);


%% EEG spectrogram of behavior arousal moment
dt = timeEEG(2)-timeEEG(1);
params=struct;
params.tapers=[10 19]; % [TW K] TK= time-bandwidth = sampling frequency*spectral width, K = 2*TW - 1
params.Fs=1/dt; % Set sampling rate here
params.fpass=[8 12]; % Set frequency range here
movingwin=[10 2]; % [windowlength windowslide]
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);

%% EEG spectrogram of behavior arousal moment
freqLow = 8;
freqHigh = 12;
params.fpass=[freqLow freqHigh]; % Set frequency range here
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);


arous_EEG = figure(); subplot(2,1,1);
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
hold on
x=[arousTime arousTime];y=[freqLow freqHigh];plot(x,y, 'k-');
plot(arousClickTime, ((freqLow+freqHigh)/2)*arousClicks, 'k*')
hold off
set(gca,'YDir','normal');colormap('jet'); xlabel('time'); ylabel('frequency')
title('EEG Spectrogram over 60 seconds')
subplot(2,1,2)
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
hold on
x=[arousTime arousTime];y=[freqLow freqHigh];plot(x,y, 'k-');
plot(arousClickTime, ((freqLow+freqHigh)/2)*arousClicks, 'k*')
hold off
set(gca,'YDir','normal');axis([timeStar timeEn freqLow freqHigh]);colormap('jet')
xlabel('time');ylabel('frequency');title('EEG Spectrogram over 6 seconds')


%% The additional notes Bev gave me in slack

figure();
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
hold on 
x=[arousTime arousTime];                            %For my script will probably delete hold on to hold off
y=[0 25];
plot(x,y, 'k-')
%plot(arousClickTime, 20*arousClicks, 'k*')
hold off
set(gca,'YDir','normal')
colormap('jet')
xlabel('time')
ylabel('frequency')
title('EEG Spectrogram')
