%% ECG Peaks and Plot
%Trying to figure out how to ID the BCG artifact with find peaks
t = timeEEG;        % Time Vector                                          
[Rpks,Rlocs] = findpeaks(ECG,'MinPeakHeight',1e3,'MinPeakDistance',150);
Rtime = t(Rlocs);
figure()
plot(timeEEG,ECG,'r')            
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
subjectsB = [2:10,15,17,19,20,21,22,24];
j = 1;
for i=subjectsB
    subID = num2str(i);
    
    firstpath = ['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/osceeg',subID,'b'];
    secondpath = '/eeg/fs200_averef/run01'; 
    folder = [firstpath,secondpath,'/rpeaks.mat'];
    present = exist(folder);
    
    
    if present>0
        pks_existrun1(j) = str2num(subID);
        value(j) = present;
        j = j+1;
    end
end

%% save the subjects id that have the rpeaks file
rpksexist.run01 = [2,3,5,6,7,8,9,10];
rpksexist.run02 = [2,3,5,6,7,8,9,10];
rpksexist.run03 = [3,6,7,9,10];
 %just for reference, these are the possible subjects & runs that have the
 % rpeaks file 



%% creating the time intervals
%t_int{i}=[start,end];

for i = 1:length(rpks)
    t_int{i}=[rpks(i),rpks(i)+.3];
    idx{i} = find((timeEEG >= t_int{i}(1)) & (timeEEG <= t_int{i}(2)));
end

%%
% 
% for i = 1:length(rpks)
%     idx{i} = find((timeEEG >= t_int{i}(1)) & (timeEEG <= t_int{i}(2)));
% end
for i=1:length(rpks)
    [pks{i},locs{i}] = findpeaks(EEG125(idx{i}));
    adjlocs{i} = locs{i} + idx{i}(1)-1;                               % Adjust ?locs? To Correct For Offset
end 
   %% 
    figure()
    plot(timeEEG, EEG125)
    hold on
    for i=1:length(rpks)
        plot(timeEEG(adjlocs{i}), pks{i}, 'vr','MarkerFaceColor','r')
    end
    hold off
    grid
    title('EEG with BCG Artifact Marked');
