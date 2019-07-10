%Trying to figure out how to ID the BCG artifact with find peaks
figure()
findpeaks(-1*ECG,'MinPeakHeight',1e3,'MinPeakDistance',150);
%Use ECG peaks to find the EEG BCG artifact  


t = timeEEG;                                             % Time Vector
y = EEG125;                                              % Signal
t_int = [819.7, 820];                                    % Time Interval
idx = find((t >= t_int(1)) & (t <= t_int(2)));           % Indices Corresponding To Time Interval
[pks,locs] = findpeaks(y(idx),'MinPeakHeight',20);       % Find Peaks In Time Interval
adjlocs = locs + idx(1)-1;                               % Adjust ?locs? To Correct For Offset
figure
plot(t, y)
hold on
plot(t(adjlocs), pks, '^r')
hold off
grid