%Plots the EEG data with the ECG data in the same figure, but different
%axis
function ecgcomboplot(ECGdata,EEGdata,channum,timeEEG,rpks)
yval = ones(size(rpks))*2000;


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