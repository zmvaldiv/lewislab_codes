%% Function checks the type of the eeg channel
% Channum - channum must be an integer, can be a matrix of various channels
% to check
% Path - path must be the path specific to the subject number and run

function [type] = checktype(channum,path)

hdr = loadchan(path,'hdr');

for i = 1:length(channum)
    type{i,1} = ['c',num2str(channum(i))];
    type{i,2} = char(hdr.chantype(channum(i)));
    
end 
    
end