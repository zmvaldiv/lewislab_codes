%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Quick Plot Data 

%   By: SW, Katherine, Zenia 
%   June 2019 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%save out eeg data ( i had two datasets loaded in and wanted the second)
dat=ALLEEG.data;

%define sampling rate and dt
fs = 2048; % from header 
dt = 1/fs;

%make a time axis for plots 
t = -1:dt:2-dt;

%% Plot Evoked potential  
figure()
plot(t, detrend(mean(dat(7, :,:),3))) %channel 7 is TP7 
title('Pink Noise Run 02, Channel TP7') 



%% Channel TP8  = #24
figure;plot(t, detrend(mean(dat(8, :,:),3))) %channel 7 is TP7 
title('Pink Noise Run 02, Channel TP8') 


%% Channel Cz
figure;plot(t, detrend(mean(dat(32, :,:),3))) %channel 7 is TP7 
title('Pink Noise Run 02, Channel Cz') 




