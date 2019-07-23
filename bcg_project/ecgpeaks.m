%% ECG Peaks and Plot
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
