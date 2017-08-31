function [ NetPeriods ] = DetectPeriodTypes( NetDVec,DenTHS,TW)
%DETECTPERIODTYPES Summary of this function goes here
%   Detailed explanation goes here
T= size(NetDVec,2);
clusters=NetDBSCAN(NetDVec,DenTHS,TW);
ID=1:T;
stMark=logical([diff(clusters),0]);
clusterMask=logical(clusters);
finalMask=stMark & ~(clusterMask);
NetDDiffVec=[diff(NetDVec),0];
stID=ID(finalMask); % vector of during period start point indices
%     #NetPeriods[i,0]: st of pre, NetPeriods[i,1]: st of during, NetPeriods[i,2]: end of during
NetPeriods=zeros(size(stID,2),3);
%     # ======== find pre/during coordination
    for i=1:size(stID,2)
         stD=stID(i)+1; % during st point
 
         % Seek back the pre st from the during st
             for j=1: (stD -1)
                currinx=stD-j;

                % Find the area that has negative first derivative value
                 if NetDDiffVec(currinx)<0 || NetDVec(currinx) == 0% just make sure that it's okay to use average
                    if (currinx-TW)>=1 %# use average of neighbors instead of single previous point
                        if mean(NetDDiffVec(currinx-TW:currinx)) || mean(NetDVec(currinx-TW:currinx)) == 0
                            break;
                        end
                    else
                        break;
                    end
                 end
             end
         stP=currinx; % pre st point
 
       % Seek further the end during from the during st
        for j=1:T
            currinx=stD+j;
            if currinx >=T
                currinx=T;
                break;
            end

            % Find the area that has zero first derivative value
            if clusters(currinx)== 0
                % just make sure that it's okay to use average
                break
            end
        end
        fnD=currinx;
        NetPeriods(i,1)=int64(stP);
        NetPeriods(i,2)=int64(stD);
        NetPeriods(i,3)=int64(fnD);
    end
    if isempty(NetPeriods)
        return;
    end
   %remove cascade period
    NetDisjointPeriods=[];
    prev=NetPeriods(1,:);
    curr=NetPeriods(1,:);
    for i= 1:size(NetPeriods,1)
        curr=NetPeriods(i,:);
        if curr(1)==prev(1) % one is a subset of another
            if curr(3)>prev(3)
                prev=curr;
            end
            
        else
            NetDisjointPeriods=[NetDisjointPeriods;prev];
            prev=curr;
        end
    end
    if ~isempty(NetDisjointPeriods)
        if curr(1)~=NetDisjointPeriods(end,1)
            NetDisjointPeriods=[NetDisjointPeriods;curr];
        end
        NetPeriods=NetDisjointPeriods;
    end

end

function clusters=NetDBSCAN(NetDVec,DenTHS,TW)
%     """
%     Create core cluster points for the point above DenTHS and some point between two clusters
%     below DenTHS but not far from timeTHS
%     :param NetDVec: Network density size 1 by T
%     :param DenTHS: network density threshold
%     :param timeTHS: time threshold
%     :return clusters: 1 by T binary vector of clusters: 1 is a point within clusters, 0 is a point outside the cluster
%     """
clusters=NetDVec;
% 
%     ======== find core points (point has a value > DenTHS)
T=size(clusters,2);
clusters(clusters < DenTHS) = 0;
clusters(clusters > DenTHS) = 1;

%     # If diffVec(i) == 1, curr is 0 but next is 1.
%     # If diffVec(i) == -1, curr is 1 but next is 0.
diffVec=diff(clusters);
diffVec=[diffVec,0];
%     # ======== connect core points within TimeTHS
     i=1;
     while(i<T)
%         # ==== if there is a gap between i and j (diffVec[i]=diffVec[j]=1), then connected it
         conditions = [diffVec(i) == -1, i+1 <=T];
         if all(conditions)
            enInx = min(T,i+TW);
            for j = i+1:enInx
                if clusters(j) == 1
                    clusters(i:j)=1;
                    i=j;
                    break;
                end
            end
         end
        i=i+1;
     end
%         
        
end