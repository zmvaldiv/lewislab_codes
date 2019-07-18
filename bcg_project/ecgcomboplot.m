%Plots the EEG data with the ECG data in the same figure, but different
%axis
function ecgcomboplot(ECGdata,EEGdata,channum,timeEEG,rpks)
yval = ones(size(rpks))*2000;


figure()
ax1 = subplot(2,1,1);
plot(timeEEG,EEGdata,'b')
hold on
scatter(rpks,yval/100,'MarkerEdgeColor',[0.9290 0.6940 0.1250]);
hold off
title(['EEG Channel ',num2str(channum)])

ax2 = subplot(2,1,2);
plot(timeEEG,ECGdata,'r')            
hold on
scatter(rpks,yval,'MarkerEdgeColor',[0.9290 0.6940 0.1250]);
hold off
title('ECG') 

sgtitle('ECG and EEG with Peaks Marked')
linkaxes([ax1,ax2],'x');
end