function TrajectoriesHircMovingPlot( TrajectoryXY )
%TRAJECTORIESMOVINGPLOT Summary of this function goes here
%   Detailed explanation goes here
N=size(TrajectoryXY{1,1},2);
TrajectoryX=TrajectoryXY{1,1};
TrajectoryY=TrajectoryXY{1,2};
for i=1:N
    clf
    plot(TrajectoryX(1,i),TrajectoryY(1,i),'or','MarkerSize',5,'MarkerFaceColor','b')
    hold on
    plot(TrajectoryX(2,i),TrajectoryY(2,i),'or','MarkerSize',5,'MarkerFaceColor','m')
    plot(TrajectoryX(3,i),TrajectoryY(3,i),'or','MarkerSize',5,'MarkerFaceColor','k')
    plot(TrajectoryX(4,i),TrajectoryY(4,i),'or','MarkerSize',5,'MarkerFaceColor',[.2 .8 .3])
    text(TrajectoryX(1,i),TrajectoryY(1,i),'ID1')
    text(TrajectoryX(2,i),TrajectoryY(2,i),'ID2')
    text(TrajectoryX(3,i),TrajectoryY(3,i),'ID3')
    text(TrajectoryX(4,i),TrajectoryY(4,i),'ID4')

    plot(TrajectoryX(5:8,i),TrajectoryY(5:8,i),'or','MarkerSize',5,'MarkerFaceColor','r')
    plot(TrajectoryX(9:11,i),TrajectoryY(9:11,i),'or','MarkerSize',5,'MarkerFaceColor',[.2 .8 .3])
    plot(TrajectoryX(12:16,i),TrajectoryY(12:16,i),'or','MarkerSize',5,'MarkerFaceColor','m')
    plot(TrajectoryX(17:end,i),TrajectoryY(17:end,i),'or','MarkerSize',5,'MarkerFaceColor','k')
    title(sprintf('Time %d',i));
    pause(.005)
end

end

