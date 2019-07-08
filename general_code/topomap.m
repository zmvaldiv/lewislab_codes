%% Plot Topomap
figure;
title(['Impedance values ' condition ' run ' run])
%topoplot(imp_val, EEG.chanlocs, 'electrodes', 'on');
topoplot(imp_val, a, 'electrodes', 'on');
cbar('vert', 0, [-1 1]*max(abs(imp_val)));
colormap('jet')