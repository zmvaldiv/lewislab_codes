%Plots the EEG data with the ECG data in the same figure, but different
%axis
function ecgcomboplot(ECGdata,EEGdata,channum,timeEEG,rpeaks)
rpks = ones(size(rpeaks));
yval = rpks*2000;
for i=1:length(rpeaks)
    rpks(i) = rpeaks(i).latency/200;
end


figure()
ax1 = subplot(2,1,1);
plot(timeEEG,EEGdata,'b')
title(['EEG Channel ',num2str(channum)])

ax2 = subplot(2,1,2);
plot(timeEEG,ECGdata,'r')            
hold on
scatter(rpks,yval)
hold off
title('ECG') 

sgtitle('ECG and EEG with Peaks Marked')
linkaxes([ax1,ax2],'x');
end