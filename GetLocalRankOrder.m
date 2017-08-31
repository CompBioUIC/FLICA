function [localPRRankOrderMat,localVCHRankOrderMat,localPCHRankOrderMat]=GetLocalRankOrder( OrderMat,outVelConvexMat,outPosConvexMat,NetPeriods )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here

markPre=false(1,size(OrderMat,2));
markPost=false(1,size(OrderMat,2));

M=size(OrderMat,1);
K=size(NetPeriods,1);
%-------------------Initial area---------------------------
localPRRankOrderMat=zeros(M,K);
localVCHRankOrderMat=zeros(M,K);
localPCHRankOrderMat=zeros(M,K);
%----------------------------------------------

for i=1:K
    x=NetPeriods(i,:);
    localPRRankOrderMat(:,i)=GetRankOrder(OrderMat,x );
    localVCHRankOrderMat(:,i)=GetConvexHullRank( outVelConvexMat,x,'Velocity' );
    localPCHRankOrderMat(:,i)=GetConvexHullRank( outPosConvexMat,x,'Position' );

end


end

