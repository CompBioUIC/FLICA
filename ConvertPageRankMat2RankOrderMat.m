function [ OrderMat ] = ConvertPageRankMat2RankOrderMat( RankMat )
%CONVERTPAGERANKMAT2RANKORDERMAT Summary of this function goes here
%   Detailed explanation goes here
[M,N]=size(RankMat);
for i=1:N
    currRank= RankMat(:,i);
    [s,inx]=sort(currRank,'descend');
    vec2(inx)=1:M;
    for j=2:M
        if s(j-1)==s(j)
            vec2(inx(j))=vec2(inx(j-1));
        end
    end
    OrderMat(:,i)=vec2';
end

end

