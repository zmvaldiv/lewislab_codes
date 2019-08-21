%% ECG Peaks and Plot
%Trying to figure out how to ID the BCG artifact with find peaks
t = EEGdata.base.hdr.ts;        % Time Vector                                          
[Rpks,Rlocs] = findpeaks(-1*EEGdata.base.ecg,'MinPeakHeight',1e3);
Rtime = t(Rlocs);
figure()
plot(EEGdata.base.hdr.ts,-1*EEGdata.base.ecg,'r')            
hold on
plot(Rtime, Rpks, 'vb','MarkerFaceColor','b')
hold off
%findpeaks(ECG,'MinPeakHeight',1e3,'MinPeakDistance',150);
title('ECG with R Wave Peaks Marked');
    %Use ECG peaks to find the EEG BCG artifact  
%% EEG Peaks and Plot
y = EEG125;                                              % Signal
t_int = [819.7, 820];                                    % Time Interval
idx = find((t >= t_int(1)) & (t <= t_int(2)));           % Indices Corresponding To Time Interval
[pks,locs] = findpeaks(y(idx),'MinPeakHeight',20);       % Find Peaks In Time Interval
adjlocs = locs + idx(1)-1;                               % Adjust ?locs? To Correct For Offset
figure()
plot(t, y)
hold on
plot(t(adjlocs), pks, 'vr','MarkerFaceColor','r')
hold off
grid
title('EEG with BCG Artifact Marked');


%% Rpeaks data ???
% Just found a file rpeaks.mat in the path for 8b, run01 and like what the
% heck !! Plotting below to see what it is 

rpeaks = loadchan(channelpath,'rpeaks');  
rpks = ones(size(rpeaks));
yval = rpks*2000;
for i=1:length(rpeaks)
    rpks(i) = rpeaks(i).latency/200;
end

plot(timeEEG,ECG,'r')            
hold on
scatter(rpks,yval)
hold off

%plotted and its the rpeaks in the ecg so the entire first section of this
%script? useless 

%% Check if rpeaks file exists

% subID = num2str(8);
% run = num2str(1);
% firstpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/osceeg',subID,'b'];
% secondpath = ['/eeg/fs200_averef/run0', run]; 
% 
% folder = [firstpath,secondpath];
subjectsA = 1:25;
subjectsB = [2:10,15,17,19,20,21,22,24];
j = 1;
for i=subjectsA
    subID = num2str(i);
    
    firstpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/osceeg',subID,'a'];
    secondpath = '/eeg/fs200_averef/run01'; 
    folder = [firstpath,secondpath,'/rpeaks.mat'];
    %present = exist(folder);
    present = exist([firstpath,'/behav'])
    
    if present>0
        clicks_exist(j) = str2num(subID);
        value(j) = present;
        j = j+1;
    end
end

%% save the subjects id that have the rpeaks file
rpks_exist.run01 = [2,3,5,6,7,8,9,10];
rpks_exist.run02 = [2,3,5,6,7,8,9,10];
rpks_exist.run03 = [3,6,7,9,10];
 %just for reference, these are the possible subjects & runs that have the
 % rpeaks file 



%% creating the time intervals
%t_int{i}=[start,end];

for i = 1:length(rpks)
    t_int{i}=[rpks(i),rpks(i)+.2];
    idx{i} = find((timeEEG >= t_int{i}(1)) & (timeEEG <= t_int{i}(2)));
    [pks{i},locs{i}] = findpeaks(EEGdata.c31(idx{i}));
    adjlocs{i} = locs{i} + idx{i}(1)-1;
end

%%
% 
% for i = 1:length(rpks)
%     idx{i} = find((timeEEG >= t_int{i}(1)) & (timeEEG <= t_int{i}(2)));
% end
for i=1:length(rpks)
    [pks_238{i},locs_238{i}] = findpeaks(EEGdata.c238(idx{i}));
    adjlocs_238{i} = locs_238{i} + idx{i}(1)-1;                               % Adjust ?locs? To Correct For Offset
end 

%%
yval = ones(size(rpks))*30;
figure();
plot(timeEEG, EEGdata.c31)
hold on
for i=1:length(rpks)
    plot(timeEEG(adjlocs{i}), pks{i}, 'vr','MarkerFaceColor','r')
end
scatter(rpks,yval)
hold off
grid
title('EEG31 with BCG Artifact Marked');
%% 
yval = ones(size(rpks))*30;
plot(timeEEG, EEGdata.c31)
hold on
for i=1:length(rpks)
    plot(timeEEG(adjlocs_238{i}), pks_238{i}, 'vr','MarkerFaceColor','r')
end
scatter(rpks,yval)
hold off
grid
title('EEG238 with BCG Artifact Marked');

%%

EEGdata.c125=EEG125;
EEGdata.c126=EEG126;
EEGdata.c238=EEG238;
EEGdata.c241=EEG241;
EEGdata.c26=EEG26;
EEGdata.c31=EEG31;
%%
%EEG
EEGdata.c31=loadchan(channelpath,31); %frontal region, eeg type chan
EEGdata.c32=loadchan(channelpath,32);
EEGdata.c26=loadchan(channelpath,26);
EEGdata.c25=loadchan(channelpath,25);

%EEG
EEGdata.c116=loadchan(channelpath,116); %back/occipital region, eeg type chan
EEGdata.c126=loadchan(channelpath,126);
EEGdata.c136=loadchan(channelpath,136);
EEGdata.c149=loadchan(channelpath,149);

%BCG
EEGdata.c241=loadchan(channelpath,241);   %left frontal region
EEGdata.c244=loadchan(channelpath,244);
EEGdata.c242=loadchan(channelpath,242);

EEGdata.c238=loadchan(channelpath,238); % right frontal region
EEGdata.c234=loadchan(channelpath,234);
EEGdata.c239=loadchan(channelpath,239);

EEGdata.c256=loadchan(channelpath,256);  %left mid region
EEGdata.c82=loadchan(channelpath,82);

EEGdata.c229=loadchan(channelpath,229);  % right mid region
EEGdata.c217=loadchan(channelpath,217);

EEGdata.c146=loadchan(channelpath,146); %back/occipital region
EEGdata.c147=loadchan(channelpath,147);
EEGdata.c156=loadchan(channelpath,156);

EEGdata.c27=loadchan(channelpath,27); % frontal region
EEGdata.c20=loadchan(channelpath,20);
EEGdata.c22=loadchan(channelpath,22);
EEGdata.c14=loadchan(channelpath,14);

%% Plot the mean and standard devation 


