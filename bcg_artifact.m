%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Heart Brain Interaction EEG Artifact
% By: Zenia
% Description: Identifies the BCG artifact in EEG data and then finds the
% mean and the standard deviation of the artifact in wake and sleep.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Path information    
% number = input('subjectnum =','s');
% subjectID = ['osceeg',number];
        subjectID = 'osceeg15b';
% runnum = input('run=','s');
% run = ['run',runnum];
        run = 'run01';

mainpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subjectID];
% channelpath = [mainpath,'/eeg/fs200_averef/', run, '/c126']; 
% channelpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/c125'];
% hdrpath = [mainpath,'/eeg/fs200_averef/', run, '/hdr'];
% ecgpath = [mainpath,'/eeg/fs200_averef/', run, '/ecg'];

channelpath = [mainpath,'/eeg/fs200/', run, '/c126']; 
%channelpath = [mainpath,'/eeg/fs200_averef_regbcg/', run, '/c125'];
hdrpath = [mainpath,'/eeg/fs200/', run, '/hdr'];
ecgpath = [mainpath,'/eeg/fs200/', run, '/ecg'];



%% Load EEG data
% load(channelpath);
% EEG = ch;
% 
% load(ecgpath)
% ECG = ch;

if isempty(subjectID) == 0 || isempty(run) == 0
cd(channelpath)
    if exist('c125.mat','file') > 0 && exist('c126.mat','file') > 0
        load([channelpath,'/c125']);
        EEG125 = ch;
        load([channelpath,'/c126']);
        EEG126 = ch;
	elseif  exist('c125.mat','file') > 0 
		load([channelpath,'/c125']);
        EEG125 = ch;
	elseif exist('c126.mat','file') > 0 
		load([channelpath,'/c126']);
        EEG126 = ch;
    end
end

cd('/Users/zenia/Documents/MATLAB')


load(hdrpath);
timeEEG = hdr.ts;
timeMRI = hdr.trs; 

%% Plot EEG and ECG data
%Plots data in one figure but two different axis
figure()
ax1 = subplot(2,1,1);
plot(timeEEG,EEG,'b')
title('EEG')
% xticks([0:5:round(max(timeEEG))]); 
ax2 = subplot(2,1,2);
plot(timeEEG,ECG,'r')
title('ECG')
% xticks([0:5:round(max(timeEEG))]); 


linkaxes([ax1,ax2],'x');



