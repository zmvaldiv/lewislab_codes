%%
%Get marker times and set their value to 10 so we can see on plot 
time_recording=size(EEG.times);
evt_times=NaN(time_recording(2),1);
for i=1:numevents
    time=EEG.event(i).latency;
    evt_times(time)=10; 
end 
  
%%
%PLOTTING

figure
hold on
plot(d(1:2840000,1));
plot(evt_times, 'r.')


%%
%plotting smaller chunk

figure
hold on
plot(d(1:400000,1));ds
plot(evt_times(1:400000), 'r.')


%%
%Epoch  using eeglab function
% S10 is the marker that appears when data are on the screen
EEG_ep = pop_epoch( EEG, {'S 10'}, [-1  2], 'epochinfo', 'yes');


%%
%choose a single channel to look at 
one_chan_epoched=EEG_ep.data(5, :, :);

%get rid of extra dimension (1, 15000, 76) 
B=squeeze(one_chan_epoched); 

%average across trials -> 2nd dimension
avg_trial=mean(B, 2); 

%%
%plot trial
figure
plot(avg_trial)
title('Avg Stimulus Locked Trial')


