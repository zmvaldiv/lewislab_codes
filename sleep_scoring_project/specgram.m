%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sleep Scoring
% By: Zenia
% Description: Loads in data from cluster and plots the EEG spectrogram and
% the click times from the behav folder
    %Don't forget to add chronux to path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Path information    
% number = input('subjectnum =','s');
% subjectID = ['osceeg',number];
        subjectID = 'osceeg15b';
% runnum = input('run=','s');
% run = ['run',runnum];
        run = 'run01';

mainpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subjectID];
channelpath = [mainpath,'/eeg/fs200_averef_regbcg/', run];
hdrpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/hdr']; 
ecgpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/ecg'];
resppath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/resp'];

% Loop to check which channel to go to 
occchan = occ_chan_per_subj(subjectID);
        load([channelpath,'/c',num2str(occchan)]);
        EEG = ch;
        eegtitle = ['EEG Channel', num2str(occchan)];

%% Load EEG/ECG data
load(ecgpath);
ECG = ch;

load(hdrpath);
timeEEG = hdr.ts;
timeMRI = hdr.trs; 

%% Heart rate plotting, ecg 
figure()
plot(timeEEG,ECG,'r')
title('ECG')

%% Occ. Chan. EEG plotting
figure()
plot(timeEEG,EEG,'b')
title(eegtitle)


%% Click times, plotting
figure()
% ax1 = subplot(2,1,1);
plotclicktimes(subjectID,run)
% set(gca,'XLim',[min max],'YLim',[.9 1.1])          %Change the axis
%                                                       limits, how is tbd

%% Plot the respiratory info
% load(resppath)
% resp = ch;
% 
% figure()
% Y1 = ones(size(resp)) - .01;
% X1 = resp;
% scatter(X1,Y1,'Marker','*');
% 
% min1 = X1(1)- 50;
% max1 = X1(length(X1))+ 50;
% title('Resp Times');
% xlabel('sec');
% % set(gca,'XLim',[min1 max1],'YLim',[.9 1.1]);
% 
%% Arousal period??

clickinterval=diff(clicktimes);  %finds the difference between clicks; finds the delays 
    [sleepTime, arous] = max(clickinterval); %finding the max delay between clicks
    arousTime = clicktimes(arous+1);  %the time that corresponds to the max
    %ask bev why, I'm a little confused of its purpose?
startTime = arousTime - 50;
endTime = arousTime + 50;

%% extracting arousal period
arousTimeInd = find((timeEEG > startTime) & (timeEEG < endTime));
arousTimeEEG = timeEEG(arousTimeInd);
arousEEG = EEG(arousTimeInd);

%% EEG spectrogram of behavior arousal moment
dt = timeEEG(2)-timeEEG(1);
params=struct;
params.tapers=[10 19]; % [TW K] TK= time-bandwidth = sampling frequency*spectral width, K = 2*TW - 1
params.Fs=1/dt; % Set sampling rate here
params.fpass=[0 25]; % Set frequency range here
movingwin=[10 2]; % [windowlength windowslide]
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);

%% Plotting specgram details

figure();
% ax2 = subplot(2,1,2);
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
set(gca,'YDir','normal')
colormap('jet')
xlabel('time')
ylabel('Frequency')
title('EEG Spectrogram')

% axisSpec = ax2.XLim;
% linkaxes([ax2,ax1],'x');
% 
% ax2.XLim=axisSpec;

%% Plotting Alpha
dt = timeEEG(2)-timeEEG(1);
params=struct;
params.tapers=[4 7]; % [TW K] TK= time-bandwidth = sampling frequency*spectral width, K = 2*TW - 1
params.Fs=1/dt; % Set sampling rate here
params.fpass=[8 12]; % Set frequency range here
movingwin = [10 2]; % [windowlength windowslide]
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);

figure()
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
set(gca,'YDir','normal')
colormap('jet')
xlabel('time')
ylabel('Frequency')
title('EEG Spectrogram Alpha')
caxis([-1.2 0.05])

%% Plotting Delta
dt = timeEEG(2)-timeEEG(1);
params=struct;
params.tapers=[10 19]; % [TW K] TK= time-bandwidth = sampling frequency*spectral width, K = 2*TW - 1
params.Fs=1/dt; % Set sampling rate here
params.fpass=[0 4]; % Set frequency range here
movingwin=[20 2]; % [windowlength windowslide]
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);

figure()
imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
set(gca,'YDir','normal')
colormap('jet')
xlabel('time')
ylabel('Frequency')
title('EEG Spectrogram Delta')
caxis([-.5 1])
