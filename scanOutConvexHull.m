function [ outVelConvexMat ] = scanOutConvexHull( VelMat )
%SCANOUTCONVEXHULL Summary of this function goes here
%   Detailed explanation goes here
outVelConvexMat=zeros(size(VelMat));
T=size(VelMat,2);
parfor t=2:T
    prevSet=VelMat(:,t-1);
    currSet=VelMat(:,t);
    outVelConvexMat(:,t)=IsInConvexHull1D( prevSet,currSet );
    t
end

end

function [ outConvexMat ] = IsInConvexHull1D( prevSet,currSet )
    minV=ones(size(prevSet,1),1)*min(prevSet);
    maxV=ones(size(prevSet,1),1)*max(prevSet);
    c1= isnan(currSet);
    c2= (minV<=currSet) ;
    c3= (currSet<=maxV );
    outConvexMat= -1*(~(c1 | c2));
    c4 = currSet;
    c4(~isnan(c4))=0;
    outConvexMat=outConvexMat +(~(c1 | c3))+c4;
end