t = linspace(0, 30, 1000);                              % Time Vector
y = sin(2*pi*t);                                        % Signal
t_int = [12, 12.5];                                     % Time Interval
idx = find((t >= t_int(1)) & (t <= t_int(2)));          % Indices Corresponding To Time Interval
[pks,locs] = findpeaks(y(idx));                         % Find Peaks In Time Interval
adjlocs = locs + idx(1)-1;                              % Adjust ?locs? To Correct For Offset
figure
plot(t, y)
hold on
plot(t(adjlocs), pks, '^r')
hold off
grid