
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
frontal(1,:)=loadchan(channelpath,31); %frontal region, eeg type chan
frontal(2,:)=loadchan(channelpath,32);
frontal(3,:)=loadchan(channelpath,26);
frontal(4,:)=loadchan(channelpath,25);

occip(1,:)=loadchan(channelpath,116); %back/occipital region, eeg type chan
occip(2,:)=loadchan(channelpath,126);
occip(3,:)=loadchan(channelpath,136);
occip(4,:)=loadchan(channelpath,149);

%BCG
Lfront(1,:)=loadchan(channelpath,241);   %left frontal region
Lfront(2,:)=loadchan(channelpath,244);
Lfront(3,:)=loadchan(channelpath,242);

Rfront(1,:)=loadchan(channelpath,238); % right frontal region
Rfront(2,:)=loadchan(channelpath,234);
Rfront(3,:)=loadchan(channelpath,239);

Lmid(1,:)=loadchan(channelpath,256);  %left mid region
Lmid(2,:)=loadchan(channelpath,82);

Rmid(1,:)=loadchan(channelpath,229);  % right mid region
Rmid(2,:)=loadchan(channelpath,217);

occip_b(1,:)=loadchan(channelpath,146); %back/occipital region
occip_b(2,:)=loadchan(channelpath,147);
occip_b(3,:)=loadchan(channelpath,156);

frontal_b(1,:)=loadchan(channelpath,27); % frontal region
frontal_b(1,:)=loadchan(channelpath,20);
frontal_b(1,:)=loadchan(channelpath,22);
frontal_b(1,:)=loadchan(channelpath,14);

%% Load in extra data
rawECG = loadchan(channelpath,'ecg');
ECG = -1*rawECG;    %multiply the ECG by -1 to flip it for easier reading of the R wave and R interval

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

%% Finding the average BCG artifact

mean_frontal = mean(frontal);
mean_occip = mean(occip);
mean_Lfront = mean(Lfront);
mean_Rfront = mean(Rfront);
mean_Lmid = mean(Lmid);
mean_Rmid = mean(Rmid);
mean_occip_b = mean(occip_b);
mean_frontal_b = mean(frontal_b);

%% Plot mean
figure()
plot(timeEEG,mean_frontal)
title('Frontal (EEG)')

figure()
plot(timeEEG,mean_occip)
title('Occipital (EEG)')

figure()
plot(timeEEG,mean_Lfront)
title('Left Frontal (BCG)')

figure()
plot(timeEEG,mean_Rfront)
title('Right Frontal (BCG)')

figure()
plot(timeEEG,mean_Lmid)
title('Left Mid (BCG)')

figure()
plot(timeEEG,mean_Rmid)
title('Right Mid (BCG)')

figure()
plot(timeEEG,mean_occip_b)
title('Occipital (BCG)')

figure()
plot(timeEEG,mean_frontal_b)
title('Frontal (BCG)')

% ax = cell(1,length(channel));
% j = 1;
% for i = 1:length(channel)-2
%    ax{i} = subplot(6,2,j);
%    plot(timeEEG,channel{i,3})
%    ylabel(channel{i,1}) 
%    j = j+2;
% end
% 
% title(ax{1},'EEG Means')
% xlabel(ax{6},'time (sec)')
% linkaxes([ax{:},axspec],'x');