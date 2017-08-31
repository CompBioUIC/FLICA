function [ RankOrderMat ] = GetRankOrder( OrderMat,DuringPeriod )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here
markPre=false(1,size(OrderMat,2));

M=size(OrderMat,1);
for i=1:size(DuringPeriod,1)
    x=DuringPeriod(i,:);
    markPre(1, ceil(x(1)): ceil(x(2))) = true;
end

[~,inxPreFull]= sort(sum(OrderMat(:,markPre),2));
meanPre=mean(OrderMat(:,markPre),2);
rankVec=1:M;
[MeanMat(:,1)] = meanPre;
[InxMat(inxPreFull,1)] =rankVec;
RankOrderMat=InxMat;
end

