function [ VelMat ] = TrajVel( Trajectory16ind )
%TRAJVEL Summary of this function goes here
%   Detailed explanation goes here
X=Trajectory16ind{1,1};
Y=Trajectory16ind{1,2};
T=size(X,2);
M=size(X,1);
VelMat=zeros(M,T);
for t=2:T
    for i=1:M
        v=sqrt((X(i,t)-X(i,t-1))^2+(Y(i,t)-Y(i,t-1))^2);
        VelMat(i,t)=v;
    end
end

end

