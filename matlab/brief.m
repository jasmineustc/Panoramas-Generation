% BRIEF.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     im - a grayscale image with range 0 to 1
% Returns: 
%     locs - m-by-3 matrix, where the first two columns are the image
%            coordinates of keypoints and the third column is the pyramid
%            level of the keypoints
%     desc - m-by-nbits, matrix of stacked BRIEF descriptors. 
%            m is the number of valid descriptors
% usage: [locs, desc] = brief(im)

function [locs, desc] = brief(im)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    load('testPattern.mat','compareX','compareY');
    sigma0=1;
    k=2^0.5;
    levels = [-1,0,1,2,3,4];
    th_r=12;
    th_contrast=0.03;
   
    [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
    [locs,desc] = computeBrief(im, locs, levels, compareX, compareY);
    
    
end