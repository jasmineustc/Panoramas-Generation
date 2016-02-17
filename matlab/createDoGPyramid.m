% CREATEDOGPYRAMID.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     GaussianPyramid - Matrix of size (height x width x num_levels)
%     levels          - Vector with num_levels elements
% Returns: 
%     DoGPyramid - A matrix representing the DoG pyramid. Should have
%                  dimensions (height x width x num_levels - 1)
%     DoGLevels  - A vector 
%
% usage: [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)


function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    [row,col,level]=size(GaussianPyramid);
    I=reshape(GaussianPyramid(:,:,1),row*col,1);
    for i = 2:length(levels)
        temp_G=GaussianPyramid(:,:,i)-GaussianPyramid(:,:,i-1);
        DoGPyramid(:,:,i-1)=temp_G;
        DoGLevels(i,1)=levels(1,i);
    end

end
