function plotclicktimes(subject,run)
%loads data from mgh from the specified subject and run
clickdata=load(['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subject ,'/behav/', run,'_clicktimes.mat']);
assignin('base','clicktimes',clickdata.clicktimes);
Y = ones(size(clickdata.clicktimes));
X = clickdata.clicktimes;
min = X(1)- 50;
max = X(length(X))+ 50;
scatter(X,Y,'Marker','*');
title('Click Times');
xlabel('sec');
set(gca,'XLim',[min max],'YLim',[.9 1.1]);
end
