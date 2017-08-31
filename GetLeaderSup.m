function [LeaderSup]=GetLeaderSup( OrderMat,RankOrderMat,DuringPeriod )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here

markPre=false(1,size(OrderMat,2));
markPost=false(1,size(OrderMat,2));

M=size(OrderMat,1);
%-------------------Initial area---------------------------
LeaderSup=0;
[~,LeaderID]=min(RankOrderMat(:,1));
%----------------------------------------------
K=size(DuringPeriod,1);
IndexLim=1:M;
for i=1:K
    x=DuringPeriod(i,:);
    RankOrderVec=GetRankOrder(OrderMat,x);
    if RankOrderVec(LeaderID,1)==1
        LeaderSup=LeaderSup+1;
    end
end
%--------Calculate percentage
div=K;
LeaderSup=LeaderSup/div;
%----------------------------
end

