%% ECG Peaks and Plot
% Finds the ecg peaks and simply plots the ecg sans peaks
rmpath('/Users/zenia/Documents/MATLAB/chronux_2_12 2/spectral_analysis/continuous/findpeaks.m');
t = timeEEG;        % Time Vector                                          
[Rpks,Rlocs] = findpeaks(ECG,'MinPeakHeight',1e3,'MinPeakDistance',100);
Rtime = t(Rlocs);
figure()
plot(timeEEG,ECG,'r')

%% Plots the ecg with the peaks marked
% Useful to double check that all peaks were found; may need to alter 'MinPeakDistance' +- 50 usually 

figure()
plot(timeEEG,ECG,'r')            
hold on
plot(Rtime, Rpks, 'vb','MarkerFaceColor','b')
hold off
title('ECG with R Wave Peaks Marked');


%% heart rate
k = 60;
index = max(timeeEG)/60;
for i = 1:max(timeEEG)/60
    tind = find(Rtime > k & Rtime < k+1);
    if isempty(tind)==1
         tind = find(Rtime > k & Rtime < k+20);
         index(i) = tind(1);
    elseif length(tind) == 1
        index(i) = tind;
    else 
        index(i) = tind(1);
    end
    k = k+60;
end

hr = diff(index);

hrindex = ones(size(hr));
for i = 1:length(hr)
    hrindex(i)=find(Rtime(index(i)) == timeEEG);
    if i==1
        k = 1;
    else 
        k=hrindex(i-1);
    end
    hrtime(k:hrindex(i))=hr(i);

end

minu = timeEEG(hrindex);
eight = ones(size(minu))*65;

hrtime(length(hrtime):length(timeEEG))=hr(length(hr));

figure()
plot(timeEEG,hrtime)
hold on
scatter(minu,eight)
hold off
title('Heart Rate')
xlabel('time (sec)')
ylabel('HR (bpm)')
