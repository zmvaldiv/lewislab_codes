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
for i=1:length(rpeaks)
    rpks(i) = rpeaks(i).latency;
end

fs200 = rpks/200;
numone=ones(size(rpks));

plot(timeEEG,ECG,'r')            
hold on
scatter(fs200,numone*2000)
hold off

%plotted and its the rpeaks in the ecg so the entire first section of this
%script? useless 


