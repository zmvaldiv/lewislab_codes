% Analyzing the RT from the subject's button presses


%% calculate accuracy

%fname ='/Users/sdwilli/Desktop/WhiteNoise_run5_RT'; 
% subject = 'SWS02';
% run = 'TONEchecker_2019-07-03_14-39-56.mat';
% fnname = ['/Volumes/Research/eng_research_lewislab/data/SWS/',subject ,'/behavior/',run]
% 
maxrt=0.8;
realswitches=sum(switches<expdur);
rt=zeros(length(realswitches),1);



%% we've also got some NaNs in here
rt(~isnan(rt)) = []; %getting rid of them 
 
 
for i=1:(realswitches)
    resp=trtimes(keyval~=0&keyval~=187);
    resp=resp-allt(1)-switches(i);
    resp=resp(resp>0&resp<maxrt);
    if isempty(resp)
        rt(i)=nan;
    else
        rt(i)=min(resp);
    end
end
disp(['Responses: ' num2str(sum(~isnan(rt))/length(rt)*100) '%']);
disp(['Mean RT: ' num2str(nanmean(rt)*1000) ' ms']);

%save(fname,'rt');




