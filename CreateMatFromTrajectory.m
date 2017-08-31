function [CorrMat,NetDVec,RankMat]= CreateMatFromTrajectory(TrajectoryXY,timeShiftWin,traWin)
%CREATEMATFROMTRAJECTORY Summary of this function goes here
%   Detailed explanation goes here
% This function is used to create dynamic following network from time
% series set

% INPUT: TrajectoryXY, 1xD cells of D-dimensional time series set
% TrajectoryXY{1,d}, MxN float matrix of dth dimention of M time series, which have length T

% OUTPUT: MxMxT Dynamic following network CorrMat;
% each CorrMat(:,:,t) represents the adjacency matrix of a following netwok at time t.
% 1xT Network density time series NetDVec; each NetDVec(t) represents a network density at time t. 
% MxT PageRank time series RankMat; each RankMat(:,t) represents PageRank eigen vector at time t.
% Note that if RankMat(i,t) > RankMat(j,t),
% then an individual i has higher rank than j at time t.

damping=0.9;

[M,T]=size(TrajectoryXY{1,1});
CorrMat =zeros (M,M,T);
NetDVec= zeros(1,T);
RankMat=zeros(M,T);
CorrMatcurr=[];
for t=1:timeShiftWin:T
    
    if (t+traWin-1) >= T && t~=1
        CorrMat(:,:,t:T)=repmat(CorrMatcurr,1,1,T-t+1);
        NetDVec(t:T)=repmat(link_density(CorrMatcurr),1,T-t+1);
        RankMat(:,t:T)=repmat(NetRanking(CorrMatcurr,damping),1,T-t+1);
        break;
    else
        %--- Create corrMat 
        interval=t:(t+traWin-1); % current interval I
        CorrMatcurr= segmentTr2FollNet(TrajectoryXY,interval); % create a following network
        CorrMat(:,:,t:t+timeShiftWin-1)=repmat(CorrMatcurr,1,1,timeShiftWin);
        %--- Create Link Density
        NetDVec(t:t+timeShiftWin-1)=repmat(link_density(CorrMatcurr),1,timeShiftWin);
        RankMat(:,(t:t+timeShiftWin-1))=repmat(NetRanking(CorrMatcurr,damping),1,timeShiftWin);
    end
    t
end

end

function CorrMatcurr= segmentTr2FollNet(TrajectoryXY,interval)
N= size(TrajectoryXY{1,1},1);
CorrMatcurr=zeros(N,N);
PairSet={};
k=1;
for i=1:N
    tr1=CvtTrajectoryXY2Segment(TrajectoryXY,interval,i);
    for j=i+1:N
        tr2=CvtTrajectoryXY2Segment(TrajectoryXY,interval,j);%[TraSegmentX(j,:);TraSegmentY(j,:)];
        PairSet{k}={tr1,tr2,i,j};
        k=k+1;
    end
end
ReMat=zeros(size(PairSet,2),1);
parfor k=1:size(PairSet,2)
    tr1=PairSet{k}{1};
    tr2=PairSet{k}{2};
    [~, warp]=DTW2(tr1,tr2);
    warp=warp(~isnan(warp));
    ReMat(k)=mean(sign(warp));
end
for k=1:size(PairSet,2)
    i=PairSet{k}{3};
    j=PairSet{k}{4};
    sg=ReMat(k);
    if sg>0
        CorrMatcurr(j,i)=sg;
    elseif ~isnan(sg)
        CorrMatcurr(i,j)=abs(sg);
    end
end

end
function tr=CvtTrajectoryXY2Segment(TrajectoryXY,interval,k)
D= max(size(TrajectoryXY));
T= max(size(interval));
tr=zeros(D,T);
for d=1:D
    tr(d,:)=TrajectoryXY{1,d}(k,interval);
end

end
function [RankVec]=NetRanking(currNetMat,damping)
N= size(currNetMat,1);
RankVec=ones(N,1);
delta = 0.0001;
%--- Revised A to be Stochastic matrix
for i=1:N
    tt= sum(currNetMat(i,:));
    if tt == 0
        Ai=ones(1,N)/N;
        currNetMat(i,:)=currNetMat(i,:)+Ai;
    else
        currNetMat(i,:)=currNetMat(i,:)/tt;
    end
end
%--- Power Iteration
MM=1000;
for i=1:MM
    prevV=RankVec;
    RankVec=(1-damping)*ones(N,1)+damping*(currNetMat')*RankVec;
    if norm(RankVec - prevV) <delta
        break;
    end
end
RankVec=RankVec/N;
end

