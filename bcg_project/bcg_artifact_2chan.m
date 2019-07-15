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

EEG125 = loadchan(channelpath,125);    %channel type is bcg
EEG126 = loadchan(channelpath,126);    %channel type is eeg
EEG31 = loadchan(channelpath,31);      %channel type is eeg
EEG26 = loadchan(channelpath,26);      %channel type is bcg
EEG241 = loadchan(channelpath,241);    %channel type is cheek
EEG238 = loadchan(channelpath,238);    %channel type is cheek

hdr = loadchan(channelpath,'hdr');
timeEEG = hdr.ts;

%% Plot EEG and ECG data
%Plots data in one figure but two different axis
ecgcomboplot(ECG,EEG125,125,timeEEG);

ecgcomboplot(ECG,EEG126,126,timeEEG);

ecgcomboplot(ECG,EEG31,31,timeEEG);

ecgcomboplot(ECG,EEG26,26,timeEEG);

ecgcomboplot(ECG,EEG241,241,timeEEG);

ecgcomboplot(ECG,EEG238,238,timeEEG);





