function DataOut=FLICAfunc3( traWin,timeShiftWin, TrajectoryXY,outputPath,LamdaTHS )
%FLICAFUNC Summary of this function goes here
%   Detailed explanation goes here
% LamdaTHS is a percentile of network density time series values
% If LamdaTHS is not set, by default, it is a mean of a network density
%load(inputPath); % ===== trajectories input file
%============== process parts
if exist(outputPath, 'file')
    load(outputPath)
    if (exist('DataOut','var'))
        CorrMat=DataOut.CorrMat;
        NetDVec=DataOut.NetDVec;
        RankMat=DataOut.RankMat;
        OrderMat=DataOut.OrderMat;
    end
else
    [CorrMat,NetDVec,RankMat] = CreateMatFromTrajectory(TrajectoryXY,timeShiftWin,traWin);
    [ OrderMat ] = ConvertPageRankMat2RankOrderMat( RankMat );
end

if ( ~exist('LamdaTHS','var') || isempty(LamdaTHS)) % we use mean of network density (\lambda) as default
    LamdaTHS=-1;
    LamdaTHS_ = mean(NetDVec);
else
    LamdaTHS_=prctile(NetDVec,LamdaTHS);
end
[ NetPeriods ] = DetectPeriodTypes( NetDVec,LamdaTHS_,traWin); % coordination events inference
if isempty(NetPeriods)
    NetPeriods=[1,length(NetDVec)-1,length(NetDVec)];
    %return;
end

[ InitRankOrderMat ] = GetRankOrder( OrderMat,NetPeriods );
[ GlobalRankOrderMat ] = GetGlobalRankOrder( OrderMat );

%[localPRRankOrderMat,localVCHRankOrderMat,localPCHRankOrderMat]=GetLocalRankOrder( OrderMat,outVelConvexMat,outPosConvexMat,NetPeriods );
%[features] = GetModelSelectionFeatures( OrderMat,outVelConvexMat,outPosConvexMat,InitRankOrderMat,RankVelOutConvexMat,RankPosOutConvexMat,NetPeriods );
% %============== output
DataOut.NetDVec=NetDVec;
DataOut.CorrMat=CorrMat;
DataOut.RankMat=RankMat;
DataOut.OrderMat=OrderMat;
DataOut.NetPeriods=NetPeriods;
DataOut.InitRankOrderMat=InitRankOrderMat;
DataOut.GlobalRankOrderMat=GlobalRankOrderMat;

DataOut.traWin=traWin;
DataOut.LamdaTHS=LamdaTHS;
% DataOut.localPRRankOrderMat=localPRRankOrderMat;
% DataOut.localVCHRankOrderMat=localVCHRankOrderMat;
% DataOut.localPCHRankOrderMat=localPCHRankOrderMat;
% methodComparePlot3( RankOrderMat,RankPosOutConvexMat,RankVelOutConvexMat,traWin, timeShiftWin);
save(outputPath,'DataOut');

end

