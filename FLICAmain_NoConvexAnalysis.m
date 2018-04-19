
% FLICA: A Framework for Leader Identification in Coordinated Activity
% Developer: C. Amornbunchornvej
% Date: Febuary 12, 2017
% Copyright © 2017 University of Illinois at Chicago.
% This framework has deployed the Matlab Tools for Network Analysis (2006-2011)
% see http://strategic.mit.edu/downloads.php?page=matlab_networks
%============== input
% Setting Everything here
traWin = 20; % time windows (\omega)
timeShiftWin=20; % time shift window (\delta)
%inputPath='EMTrajectoryXY100.mat';
%inputPath='TrajectoryXY1.mat'; % ===== trajectories input file
load('NASDAQ_Data.mat','DataMat');

% If you have k-dimentional time series, then TrajectoryXY={A1,...Ak};
% Ai is the ith dimension matrix where each row represents an individual
% time series and each column represents a time step.
TrajectoryXY={DataMat}; 


% Note that if outputPath exists, the framework will skip some heavy
% computational module, otherwise the framework will run from the
% beginning.
%outputPath='FLICANetData100.mat'; % =====  output file
outputPath='FLICANetData.mat'; % =====  output file

%============== process parts 
DataOut=FLICAfunc3( traWin,timeShiftWin, TrajectoryXY,outputPath);
% %============== output
%=== plot leadership ordered lists
%methodComparePlot3( DataOut.GlobalRankOrderMat,DataOut.InitRankOrderMat,DataOut.localPRRankOrderMat,traWin, timeShiftWin);
% ===== output: result plot is report at the directory "plot"
