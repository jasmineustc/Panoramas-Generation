% RANSACH.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes homogaphy using ransac
%
% Arguments: 
%     matches  - matches between locs1 and locs2
%     locs1    - feature points in img1
%     locs2    - feature points in img2
%     nIter    - number of iterations for RANSAC
%     tol      - tolerance for a point to be an inlier
% Returns: 
%     bestH    - homography that has the most inliers
%     bestError- error value of the bestH
%     inliers  - vector of 1's and 0's matching the vector matches, where 1 is inliers
%
% usage: [bestH, bestError, inliers] = ransacH(matches, locs1, locs2, nIter, tol)

function [bestH, bestError, inliers] = ransacH(matches, locs1, locs2, nIter, tol)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    if ~exist('nIter', 'var') || isempty(nIter)
    nIter = 1500;
    end
    
    if ~exist('tol', 'var') || isempty(tol)
    tol = 0.5;
    end

    inliers=zeros(size(matches,1),1);
    temp_inliers=zeros(size(matches,1),1);
    
    one=ones(size(matches,1),1);    
    whole_p1_match=[locs1(matches(:,1),[2, 1]),one]';
    whole_p2_match=[locs2(matches(:,2),[2, 1]),one]';
    
    for i=1:nIter
        randpoint=randperm(size(matches,1),8);
        p1=locs1(matches(randpoint,1),[2, 1])';
        p2=locs2(matches(randpoint,2),[2, 1])';
    
        [H2to1_temp] = computeH_norm(p1, p2);
        new_p1=H2to1_temp*whole_p2_match;
        new_p1=new_p1./repmat(new_p1(3,:),3,1);
        temp_tol=zeros(size(new_p1,2),1);
        s=(new_p1-whole_p1_match);
        
        for i=1:size(new_p1,2)
            xdiff=abs(s(1,i));
            ydiff=abs(s(2,i));
            temp_tol(i,1)=(xdiff+ydiff);
            if (temp_tol(i,1)<tol)
                temp_inliers(i,1)=1;
            end       
        end 
        
        if (sum(temp_inliers)>sum(inliers))
            inliers=temp_inliers;
            bestError = sum(temp_inliers == 0) / length(matches);
            bestH = H2to1_temp;
        end     
              
    end
 
end














