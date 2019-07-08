function plotclicktimes_v2(app,subject,run)
%loads data from mgh from the specified subject and run
ct = load(['/Volumes/Research/eng_research_lewislab/data/osceeg_frommgh/',subject,'/behav/',run,'_clicktimes.mat']);
%assignin('base','clicktimes',clickdata.clicktimes);
    Y = ones(size(ct.clicktimes));
    X = ct.clicktimes;
    min = X(1)- 50;
    max = X(length(X))+ 50;
    scatter(app.UIAxesClickTimes,X,Y,'Marker','*')
    app.UIAxesClickTimes.XLim = [min max];
end
