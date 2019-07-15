%Function loads in the data from a specific EEG channel
    %Make sure connected to SCC
function [EEGdata] = loadchan(path,channel) 
if ischar(channel)>0
 data = load([path,'/',channel]);
else
    channel = num2str(channel);
    data = load([path,'/c',channel]);
end 
EEGdata = data.ch;
end 
