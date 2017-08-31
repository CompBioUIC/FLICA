function [ outPosConvexMat ] = Position_Convexhull( Trajectory16ind )
%POSITION_CONVEXHULL Summary of this function goes here
%   Detailed explanation goes here
TraX=Trajectory16ind{1,1};
TraY=Trajectory16ind{1,2};
[N,Length]=size(TraX);
outPosConvexMat=zeros(N,Length);
PointMat = [TraX(:,1),TraY(:,1)];
PointMat=PointMat(~isnan(TraX(:,1)),:);
PointMat=double(PointMat);
if(~isempty(PointMat))
    tri = delaunayn(PointMat); % Generate delaunay triangulization
end
for i=2:Length
    QueryPoints = double([TraX(:,i),TraY(:,i)]);
    prevPoints=double([TraX(:,i-1),TraY(:,i-1)]);
    dirVecs = QueryPoints- prevPoints;
    for k=1:size(dirVecs,1)
        dirVecs(k,:)=dirVecs(k,:)/norm(dirVecs(k,:));
    end
    groupDirVec=nanmean(dirVecs);
    groupprevPoint=nanmean(prevPoints);
    parfor k=1:size(dirVecs,1)
        indDirVecs(k,:)=QueryPoints(k,:)-groupprevPoint;
        indDirVecs(k,:)=indDirVecs(k,:)/norm(indDirVecs(k,:));
        diffDegreeVec(k)= acos(dot(indDirVecs(k,:),groupDirVec))*180/pi;
    end
    headGroup = diffDegreeVec';
    headGroup(headGroup<=90)=1;
    headGroup(headGroup>90)=-1;
     % compare with the previous group centroid
    if sum(isnan(QueryPoints(:,1))) == N
        tri = [];
        continue;
    end
    if ~isempty(tri)
        tn = tsearchn(PointMat, tri, QueryPoints); % Determine which triangle point is within
        inConvexInx = tn; % Convert to logical vector
        outConvexInx=~isnan(QueryPoints(:,1));
        inConvexInx(isnan(inConvexInx))=false;
        inConvexInx=logical(inConvexInx);
        outConvexInx=outConvexInx & ~ inConvexInx;
        outPosConvexMat(:,i)=outConvexInx.*headGroup;
%---      clf
%         plot(QueryPoints(~outConvexInx),'r+') % points inside
%         hold on
%         plot(QueryPoints(outConvexInx.*headGroup==-1),'bo') % points outside
%         plot(QueryPoints(outConvexInx.*headGroup==1),'go') % points outside
    end
    %----------
    PointMat=QueryPoints;
    PointMat=double(PointMat);
    PointMat=PointMat(~isnan(TraX(:,i)),:);
    if(~isempty(PointMat)) && size(PointMat,1)>2
        tri = delaunayn(PointMat); % Generate delaunay triangulization
    else
        tri=[];
    end
    i
end

end

