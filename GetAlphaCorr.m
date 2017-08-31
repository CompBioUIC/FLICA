function [AlphaPRCorr,AlphaVelCxCorr,AlphaPosCxCorr]=GetAlphaCorr( OrderMat,outVelConvexMat,outPosConvexMat,RankOrderMat,RankVelOutConvexMat,RankPosOutConvexMat,DuringPeriod )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here

markPre=false(1,size(OrderMat,2));
markPost=false(1,size(OrderMat,2));

M=size(OrderMat,1);
%-------------------Initial area---------------------------
AlphaVelCxCorr=0;
AlphaPosCxCorr=0;
AlphaPRCorr=0;
%----------------------------------------------
K=size(DuringPeriod,1);
IndexLim=1:M;
for i=1:K
    x=DuringPeriod(i,:);
    RankOrderVec=GetRankOrder(OrderMat,x);
    RankVelOutConvexVec=GetConvexHullRank( outVelConvexMat,x,'Velocity' );
    RankPosOutConvexVec=GetConvexHullRank( outPosConvexMat,x,'Position' );

    tmp1=corr(RankOrderMat(:,1),RankOrderVec(:,1),'type','Kendall');
    tmp2=corr(RankVelOutConvexMat(:,1),RankVelOutConvexVec(:,1),'type','Kendall');
    tmp3=corr(RankPosOutConvexMat(:,1),RankPosOutConvexVec(:,1),'type','Kendall');
    if isnan(tmp1) 
       tmp1=0; 
    end
    if isnan(tmp2) 
       tmp2=0; 
    end
    if isnan(tmp3) 
       tmp3=0; 
    end
    AlphaPRCorr=AlphaPRCorr+tmp1;
    AlphaVelCxCorr=AlphaVelCxCorr+tmp2; % Pre VelCx Delta Corr
    AlphaPosCxCorr=AlphaPosCxCorr+tmp3; % Pre PosCx Delta Corr
end
%--------Calculate percentage
div=K;
AlphaPRCorr=AlphaPRCorr/div;
AlphaVelCxCorr=AlphaVelCxCorr/div;
AlphaPosCxCorr=AlphaPosCxCorr/div;
%----------------------------
end

