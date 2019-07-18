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

% channelpath = [mainpath,'/eeg/fs200/', run]; 

%% Load EEG data

rawECG = loadchan(channelpath,'ecg');
ECG = -1*rawECG;    %multiply the ECG by -1 to flip it for easier reading of the R wave and R interval

EEGdata = struct;
EEGdata.c125 = loadchan(channelpath,125);    %channel type is bcg
EEGdata.c126 = loadchan(channelpath,126);    %channel type is eeg
EEGdata.c31 = loadchan(channelpath,31);      %channel type is eeg
EEGdata.c26 = loadchan(channelpath,26);      %channel type is bcg
EEGdata.c241 = loadchan(channelpath,241);    %channel type is cheek
EEGdata.c238 = loadchan(channelpath,238);    %channel type is cheek

hdr = loadchan(channelpath,'hdr');
timeEEG = hdr.ts;
 
rpeaks = loadchan(channelpath,'rpeaks');  
for i=1:length(rpeaks)
    rpks(i) = rpeaks(i).latency/200;
end

rpks = rpks(1:length(rpks)-1);

%% Plot EEG and ECG data
%Plots data in one figure but two different axis
ecgcomboplot(ECG,EEGdata.c125,125,timeEEG,rpks);

ecgcomboplot(ECG,EEGdata.c126,126,timeEEG,rpks);

ecgcomboplot(ECG,EEGdata.c31,31,timeEEG,rpks);

ecgcomboplot(ECG,EEGdata.c26,26,timeEEG,rpks);

ecgcomboplot(ECG,EEGdata.c241,241,timeEEG,rpks);

ecgcomboplot(ECG,EEGdata.c238,238,timeEEG,rpks);

%% Finding the BCG artifact


