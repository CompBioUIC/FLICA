function [ GlobalRankOrderMat ] = GetGlobalRankOrder( OrderMat )
%GETRANKORDER Summary of this function goes here
%   Detailed explanation goes here

[~,GlobalRankOrderMat]=sort(sum(OrderMat,2));
end

