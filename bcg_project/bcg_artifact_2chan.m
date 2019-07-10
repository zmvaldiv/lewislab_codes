 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heart Brain Interaction EEG Artifact
% By: Zenia
% Description: Identifies the BCG artifact in EEG data and then finds the
% mean and the standard deviation of the artifact in wake and sleep.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Path information    

% number = input('subjectnum =','s');
% subjectID = ['osceeg',number];
        subjectID = 'osceeg8b';
% runnum = input('run=','s');
% run = ['run',runnum];
        run = 'run01';

mainpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subjectID];
channelpath = [mainpath,'/eeg/fs200_averef/', run]; 
hdrpath = [mainpath,'/eeg/fs200_averef/', run, '/hdr'];
ecgpath = [mainpath,'/eeg/fs200_averef/', run, '/ecg'];

% channelpath = [mainpath,'/eeg/fs200/', run]; 
% hdrpath = [mainpath,'/eeg/fs200/', run, '/hdr'];
% ecgpath = [mainpath,'/eeg/fs200/', run, '/ecg'];



%% Load EEG data

load(ecgpath)
ECG = ch;

load([channelpath,'/c125']);
EEG125 = ch;
load([channelpath,'/c126']);
EEG126 = ch;

load(hdrpath);
timeEEG = hdr.ts;

%% Plot EEG and ECG data
%Plots data in one figure but two different axis
figure()
ax1 = subplot(2,1,1);
plot(timeEEG,EEG125,'b')
title('EEG Channel 125')

ax2 = subplot(2,1,2);
plot(timeEEG,-1*ECG,'r')
title('ECG')

%Plots data in one figure but two different axis
figure()
ax3 = subplot(2,1,1);
plot(timeEEG,EEG126,'b')
title('EEG Channel 126')

ax4 = subplot(2,1,2);
plot(timeEEG,-1*ECG,'r')
title('ECG')

linkaxes([ax1,ax2],'x');
linkaxes([ax3,ax4],'x');





