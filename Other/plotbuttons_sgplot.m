
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% July 2019, SW 
% Purpose:  plot behavior from July 3rd wake scan (4 s audio & checkerboard bursts)
%       stimuli details: 6 bursts per 120 ON block -- 0.05 Hz 
%       also calculate the accuracy of button presses 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


cols = ['r' ,'b', 'c', 'y', 'g' ,'m' ,'k' ,'r']; 
figure
hold on
for i=1:8
   [sub_presses, acc, switches] = plotbuttons(num2str(i)) ;
   subplot(9,1, i+1)
   scatter(sub_presses, ones(length(sub_presses),1), '*', cols(i)) 
   title([ 'Run ' num2str(i) '    Accuracy: ' num2str(round(acc,1)) '%' ])
end 
subplot(9,1,1)
scatter(switches,ones(length(switches),1), '*', 'k')
title( 'Actual Color Changes')
sgtitle('Button Presses, All Runs (max RT=1.2)')
hold off

%%
function [sub_presses, acc, switches] = plotbuttons(run)

disp(['Plotting run# ' run ] )
switch run
    case '1'
        run='whitenoise_checker_2019-07-03_14-10-31.mat';
    case '2'
        run='TONEchecker_2019-07-03_14-21-03.mat';
    case '3'
        run='whitenoise_checker_2019-07-03_14-30-38.mat';
    case '4'
        run='TONEchecker_2019-07-03_14-39-56.mat';
    case '5' 
        run = 'whitenoise_checker_2019-07-03_14-50-33.mat';
    case '6'
        run = 'TONEchecker_2019-07-03_15-00-08.mat';
    case '7' 
        run = 'whitenoise_checker_2019-07-03_15-09-43.mat';
    case '8'
        run = 'TONEchecker_2019-07-03_15-19-07.mat';
end 
        
disp(run)
clear trtimes keyval      
load(['/Volumes/Research/eng_research_lewislab/data/SWS/SWS02/behavior/',run]);

%load in times at which color of dot changed 
s=load(['/Volumes/Research/eng_research_lewislab/data/SWS/SWS02/behavior/newswitch.mat']);
switches=s.switches;
% save out times of color changes
x=ones(length(switches),1);

%% pick out subjs presses
sub_presses = trtimes(find(keyval==49))- trtimes(1);


%% calculate accuracy
expdur=494;
maxrt=1.2;

clear realswitches rt resp
realswitches=sum(switches<expdur);
rt=zeros(length(realswitches),1);

for i=1:(realswitches)
    resp=trtimes(keyval~=187&keyval~=0);
    %resp=resp-allt(1)-switches(i);
    resp=resp-trtimes(1)-switches(i);
    resp=resp(resp>0&resp<maxrt);
    if isempty(resp)
        rt(i)=nan;
    else
        rt(i)=min(resp);
    end
end

acc= (sum(~isnan(rt))/length(rt)*100); 
disp(['Responses: ' num2str(sum(~isnan(rt))/length(rt)*100) '%']);
disp(['Mean RT: ' num2str(nanmean(rt)*1000) ' ms']);

%% plots 
% figure;
% hold on
% scatter(switches,x, '*');
% scatter(sub_presses, ones(length(sub_presses),1)-.001, '*', 'r')
% legend('colorchange' , 'sub press')
% sgtitle(['Button behavior, Accuracy: ' num2str(acc) '%' ])
% hold off 

end