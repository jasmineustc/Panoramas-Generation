% COMPUTEH_NORM.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
% This version normalizes the input coordinates p1 and p2 prior to calling
% compute_H() to find the actual homography. The normalizaiton scales the
% points so that the average distance to the mean of the original points is
% sqrt(2).
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
% usage: [H2to1] = computeH_norm(p1, p2)


function [H2to1] = computeH_norm(p1, p2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    [row,col]=size(p1);
    originp1=p1;
    originp2=p2;
    
    sump1_x=sum(p1(1,:))/col;
    sump1_y=sum(p1(2,:))/col;
    
    sump2_x=sum(p2(1,:))/col;
    sump2_y=sum(p2(2,:))/col;
    
    p2(1,:)=p2(1,:) - sump2_x;
    p2(2,:)=p2(2,:) - sump2_y;
     
    p1(1,:)=p1(1,:) - sump1_x;
    p1(2,:)=p1(2,:) - sump1_y;
    
    dis_p1=0;
    dis_p2=0; 
    
    for i=1:col
        dis_p1=dis_p1+((p1(1,i))^2+(p1(2,i))^2)^0.5;
        dis_p2=dis_p2+((p2(1,i))^2+(p2(2,i))^2)^0.5;
    end  
    
    coord_p1=(dis_p1/col)/(2^0.5);   
    coord_p2=(dis_p2/col)/(2^0.5);
     
    p1=p1/coord_p1;
    p2=p2/coord_p2;
      
    p1(1,:)=p1(1,:) + sump1_x;  
    p1(2,:)=p1(2,:) + sump1_y;  
    
    p2(1,:)=p2(1,:) + sump2_x;  
    p2(2,:)=p2(2,:) + sump2_y;  
    
    p1=[originp1,p1];
    p2=[originp2,p2];
    [H2to1] = computeH(p1, p2);

end












