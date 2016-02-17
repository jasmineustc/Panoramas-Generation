
% COMPUTEH.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
%
% Arguments: 
%     p1    - 2xN matrix with (x,y)^T image coordinates for image 1
%             N is the number of points.
%     p2    - 2xN matrix with (x,y)^T image coordinates for image 2
%             Each point (column) in p2 corresponds with the respective
%             column in p1
% Returns: 
%     H2to1 - 3x3 homography matrix computed from p1 and p2. It is the best
%             fit given p1 and p2 in the least-squares sense.
%
% usage: [H2to1] = computeH(p1, p2)

% p2 is matrix q, p1 is matrix p

function [H2to1] = computeH(p1, p2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE

    [row,col]=size(p1);
    one=ones(1,col);
    p=p1;
    q=p2;
    A=[];
        
    for i=1:col
        x=p(1,i);
        y=p(2,i);
        u=q(1,i);
        v=q(2,i);
        
        temp1=[u,v,1,0,0,0,-x*u,-x*v,-x];
        temp2=[0,0,0,u,v,1,-y*u,-y*v,-y];
        A=[A;temp1;temp2];
    end
    
    ata=A'*A;
    [V,D]=eig(ata);
    h2to1=V(:,1);
   
    H2to1=normc(h2to1);
    H2to1=reshape(H2to1,3,3)';
    

    

end







