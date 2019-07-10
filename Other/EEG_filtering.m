%info on EEG DATA 
%EEG.data; 
%EEG.times is in seconds
%%EEG.event is in millseconds 

%%save the data as a variable in case accidently overwrite/destroy it
dp=EEG.data;

%%Cut off last time points when cap was disconnected
dp=dp(:, 1:2840000);

%%
%Filtering/Preprocessing Adapted from Laura's script 
oldfs=5000; %EEG.srate
newfs=200; %downsample to 200 HZ
filtsize=2000;
ff=firls(filtsize,[0 0.5 0.6 50 55 oldfs/2]/oldfs*2,[0 0 1 1 0 0]);
ds=oldfs/newfs;

% filter all channels
x=filter(ff,1,c1);
x=circshift(x,[-filtsize/2]);

%%
x=x(:,floor(ds/2):ds:end);

%%
%Plotting to make sure it looks okay 
oldts=EEG.times(1:2840000);
newts=oldts(floor(ds/2):ds:end);
figure
plot(oldts,dp(2,:),newts,x(2,:));
legend({'orig','filt'});
xlabel('Time (ms)');
title('Downsampled & Filtered Data')
