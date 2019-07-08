% Spectrogram plotting for GUI
%   Made into function for ease 
                
%% Path information    
function [arousTimeEEG spec f] = specgram_v2(subject,run, clicktimes)
%number = input('subjectnum =','s');
subjectID = subject; %['osceeg',number];
%         subjectID = 'osceeg22b';
%runnum = input('run=','s');
run = run; %['run',runnum];
%         run = 'run01';

mainpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subjectID];
channelpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/c126']; 
hdrpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/hdr'];

%% Load EEG data
load(channelpath);
EEG = ch;

load(hdrpath);
timeEEG = hdr.ts;
timeMRI = hdr.trs; 

%% Click times, plotting
% figure()
% plotclicktimes(subjectID,run)
% %set(gca,'XLim',[min max],'YLim',[.9 1.1])          %Change the axis
% %                                                       limits, how is tbd

%% Arousal period??
clicktimes = clicktimes;
clickinterval=diff(clicktimes);  %finds the difference between clicks; finds the delays 
    [sleepTime, arous] = max(clickinterval); %finding the max delay between clicks
    arousTime = clicktimes(arous+1);  %the time that corresponds to the max
    %ask bev why, I'm a little confused of its purpose?
startTime = arousTime - 50;
endTime = arousTime + 50;

%% extracting arousal period
    %copied exactly from Bev (allowed ??)
arousTimeInd = find((timeEEG > startTime) & (timeEEG < endTime));
arousTimeEEG = timeEEG(arousTimeInd);
arousEEG = EEG(arousTimeInd);

%% EEG spectrogram of behavior arousal moment
    %copied exactly from Bev (allowed ??)
dt = timeEEG(2)-timeEEG(1);
params=struct;
params.tapers=[10 19]; % [TW K] TK= time-bandwidth = sampling frequency*spectral width, K = 2*TW - 1
params.Fs=1/dt; % Set sampling rate here
params.fpass=[0 25]; % Set frequency range here
movingwin=[10 2]; % [windowlength windowslide]
[spec, t, f] = mtspecgramc_detrend_laura(arousEEG,movingwin,params);


end 
%% The additional notes Bev gave me in slack

% figure();
% imagesc(arousTimeEEG,f,log10(spec')) %10*log10(S2)'
% set(gca,'YDir','normal')
% colormap('jet')
% xlabel('time')
% ylabel('Frequency')
% title('EEG Spectrogram')
