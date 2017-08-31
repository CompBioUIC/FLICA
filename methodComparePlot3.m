function methodComparePlot3( RankOrderMat,InitRankOrderMat,localPRRankOrderMat,TW, TS)
%METHODCOMPAREPLOT Summary of this function goes here
%   Detailed explanation goes here
DataMat=[RankOrderMat,InitRankOrderMat];
M=size(DataMat,1);
YLabels=[{'Global Leader'},{'Initiator Leader'}];
XLabels={};
for i=1:M
    str=sprintf('ID:%d',((i)));
    XLabels=[XLabels;{str}];
end

clf
subplot(4,1,[1])
heatmap(DataMat',XLabels,YLabels,'%d','TickAngle', 45,'ColorMap', 'cool','UseFigureColormap',false,'ShowAllTicks', true,'ShowAllTicks',true);

xlabel('Ranking [1,M]') 
ylabel('Individuals')
title('Leadership Rank Ordered Lists');
subplot(4,1,[2,4])
YLabels=XLabels;
XLabels={};
for i=1:size(localPRRankOrderMat,2)
    str=sprintf('#%d',((i)));
    XLabels=[XLabels;{str}];
end

heatmap(localPRRankOrderMat,XLabels,YLabels,'%d','TickAngle', 45,'ColorMap', 'cool','UseFigureColormap',false,'ShowAllTicks', true,'ShowAllTicks',true);
xlabel('Coordination Events (Local Leadership Rank Ordered Lists)') 
ylabel('Individuals')
set(gcf, 'Position', get(0, 'Screensize'));
mkdir('plots');
namePlot=sprintf('plots/ComparedMethodTW%dTS%dPlot.fig',TW, TS);
saveas(gcf,namePlot);
namePlot=sprintf('plots/ComparedMethodTW%dTS%dPlot.png',TW, TS);
saveas(gcf,namePlot);
end

