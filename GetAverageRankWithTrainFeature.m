function [ avgRankOrderVec, GLfeature, LeaderSup, localRanks ] = GetAverageRankWithTrainFeature(RankMat, NetPeriods)
%GETAVERAGERANKWITHTRAINFEATURE Summary of this function goes here
%   Detailed explanation goes here

%     nCycles=NetPeriods.shape[0]
%     M= RankMat.shape[0]
%     totalRank=np.zeros((M,1))
%     avgRankSet=[]
%     LeaderSup=0.0
%     RankMat[RankMat<0]=0
%     for i in range(nCycles):
%         stInxPre=NetPeriods[i,0]
%         stInxDuring=NetPeriods[i,1]
%         currMat=RankMat[:,stInxPre:stInxDuring] # choose only pre period
%         ranksOrders,avgRankOrder=GetOrderFromRankVec(currMat)
%         totalRank=totalRank+ np.matrix(np.sum(ranksOrders,axis=1)).transpose()
%         avgRankSet.append(avgRankOrder)
%     _, globalRank=GetOrderFromRankVec(totalRank,reverse=1)
%     leaderInx=np.argmin(globalRank)
% 
%     % === Global vs. Local rank order
%     corrVec=[]
%     for i in range(nCycles):
%         localRankOrder=avgRankSet[i]
%         corr,_=st.kendalltau(globalRank,localRankOrder)
%         corrVec.append(corr)
%         if localRankOrder[leaderInx] == 1:
%             LeaderSup+=1
% 
%     avgRankOrderVec=globalRank
%     GLfeature = np.nanmean(corrVec)
%     LeaderSup/=nCycles
%     localRanks=np.matrix(avgRankSet)
end
function  [ranksOrders, avgRankOrder]=GetOrderFromRankVec(RankVecs, reverse =0):
%     """
%     :param RankVec: M by 1 vector of ranking (greater value, higher ranking)
%     : param reverse: if 1 the highest rank is the lowest value otherwise the hiest rank is the highest value
%     :return ranksOrder: M by 1 vector of ranking order (1 is the highest rank which has the maximum value in RankVec)
%     """
%     subT=RankVecs.shape[1]
%     M=RankVecs.shape[0]
%     ranksOrders=np.zeros((M,subT))
%     #===== rank order
%     for i in range(subT):
%         array = st.rankdata(RankVecs[:,i].tolist(),method='dense')
%         if reverse==0:
%             ranksOrders[:,i] = np.array(max(array)-array+1)
%         else:
%             ranksOrders[:,i] = np.array(array+1)
%     avgRankOrder=st.rankdata(np.sum(ranksOrders,axis=1).tolist(), method='dense')
end

