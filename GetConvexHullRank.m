function  RankOutConvexMat=GetConvexHullRank( outPosConvexMat,DuringPeriod,Typestr )
%PREPOSTCONVEXHULLPEAKSPLOT Summary of this function goes here
%   Detailed explanation goes here
PeakList=1:size(DuringPeriod,1);
[M,N]=size(outPosConvexMat);
preMark =false(1,N);
for i=1:size(PeakList,2)
    x=DuringPeriod(PeakList(i),:);
    preMark(1,x(1):x(2)) = true;
end

[OutConvexMat(:,1)] = (sum(outPosConvexMat(:,preMark) == 1,2)/sum(preMark)) - (sum(outPosConvexMat(:,preMark)==-1,2)/sum(preMark));
%[OutConvexMat(:,2)] = (sum(outPosConvexMat(:,preMark)==-1,2)/sum(preMark));
[ RankOutConvexMat(:,1) ] = ConvertPageRankMat2RankOrderMat( OutConvexMat(:,1) );

% namePlot=sprintf('Peak plots/%sConvxHullPlot.fig',Typestr);
% saveas(gcf,namePlot);
end

