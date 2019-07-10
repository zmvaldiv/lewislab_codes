
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


