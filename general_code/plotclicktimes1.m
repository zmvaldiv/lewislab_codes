function plotclicktimes1(subject,run)
%loads data from the specified subject and run
load(['/Volumes/Research/eng_research_lewislab/data/SWS/',subject ,'/behavior/',run]);
assignin('base','trtimes',trtimes);
assignin('base','keyval',keyval);
% Finds and plots the correct and missed clicks
missedclicks = find(keyval==187);
clicks = find(keyval==49 | keyval==50);
Y = ones(length(clicks),1);
X = trtimes(clicks);
scatter(X,Y,'*','b');

hold on
Y2 = ones(length(missedclicks),1);
%Y2 = Y2 - .001;      %easier to see when zoomed in
Y2 = Y2 - .01;
X2 = trtimes(missedclicks);
scatter(X2,Y2,'*','r');
hold off

min = X2(1)- 50;
max = X2(length(X2)) + 50;
title('Click Times');
xlabel('sec');
set(gca,'XLim',[min max],'YLim',[.9 1.1]);
legend('Correct Clicks','Missed Clicks');
end
