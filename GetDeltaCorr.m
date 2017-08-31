function [DeltaVelCxCorr,DeltaPosCxCorr]=GetDeltaCorr( OrderMat,outVelConvexMat,outPosConvexMat,DuringPeriod )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here

markPre=false(1,size(OrderMat,2));
markPost=false(1,size(OrderMat,2));

M=size(OrderMat,1);
%-------------------Initial area---------------------------
DeltaVelCxCorr=0;
DeltaPosCxCorr=0;
%----------------------------------------------
K=size(DuringPeriod,1);
IndexLim=1:M;
for i=1:K
    x=DuringPeriod(i,:);
    RankOrderVec=GetRankOrder(OrderMat,x);
    RankVelOutConvexVec=GetConvexHullRank( outVelConvexMat,x,'Velocity' );
    RankPosOutConvexVec=GetConvexHullRank( outPosConvexMat,x,'Position' );
    
    [PRval,PRI]=sort(RankOrderVec);
    PRval=PRval(IndexLim,1);
    VelCxVal=RankVelOutConvexVec(PRI(IndexLim,1),1);
    PosCxVal=RankPosOutConvexVec(PRI(IndexLim,1),1);
    tmp2=corr(PRval,VelCxVal,'type','Kendall');
    tmp3=corr(PRval,PosCxVal,'type','Kendall');
    if isnan(tmp2) 
       tmp2=0; 
    end
    if isnan(tmp3) 
       tmp3=0; 
    end
    DeltaVelCxCorr=DeltaVelCxCorr+tmp2; % Pre VelCx Delta Corr
    DeltaPosCxCorr=DeltaPosCxCorr+tmp3; % Pre PosCx Delta Corr
end
%--------Calculate percentage
div=K;
DeltaVelCxCorr=DeltaVelCxCorr/div;
DeltaPosCxCorr=DeltaPosCxCorr/div;
%----------------------------
end

