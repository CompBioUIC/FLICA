function [A] = GetModelSelectionFeatures( OrderMat,outVelConvexMat,outPosConvexMat,RankOrderMat,RankVelOutConvexMat,RankPosOutConvexMat,NetPeriods )
%GETMODELSELECTIONFEATURES Summary of this function goes here
%   Detailed explanation goes here
% Alpha is Cx vs. Cx, Delta is PR vs. Cx.
[~,AlphaVelCxCorr,AlphaPosCxCorr]=GetAlphaCorr( OrderMat,outVelConvexMat,outPosConvexMat,RankOrderMat,RankVelOutConvexMat,RankPosOutConvexMat,NetPeriods );
[DeltaVelCxCorr,DeltaPosCxCorr]=GetDeltaCorr( OrderMat,outVelConvexMat,outPosConvexMat,NetPeriods );
[LeaderSup]=GetLeaderSup( OrderMat,RankOrderMat,NetPeriods );
A=[LeaderSup, AlphaVelCxCorr,AlphaPosCxCorr,DeltaVelCxCorr,DeltaPosCxCorr];
end

