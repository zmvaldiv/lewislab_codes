
%%
%Epoch  using eeglab function
% S10 is the marker that appears when data are on the screen
EEG_ep = pop_epoch( ALLEEG, {'S 10'}, [-1  2], 'epochinfo', 'yes');
     %will give 3 second window

%%
%this section generates a plot
%choose a single channel to look at 
one_chan_epoched=EEG_ep.data(5, :, :);

%get rid of extra dimension (1, 15000, 76) 
B=squeeze(one_chan_epoched); 
        %gets rid of extra dimensions
%average across trials -> 2nd dimension
avg_trial=mean(B, 2); 

%%
%plot trial
figure
plot(avg_trial)
title('Avg Stimulus Locked Trial')


