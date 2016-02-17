% COMPUTEPRINCIPALCURVATURE.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     DoGPyramid - Matrix of size (height x width x m)
% Returns: 
%     PrincipalCurvature - A matrix of size (height x width x m) where each
%                          element represents the curvature ratio for each
%                          corresponding point in the DoG pyramid.
%
% usage: PrincipalCurvature = computePrincipalCurvature(DoGPyramid))


function [PrincipalCurvature] = computePrincipalCurvature(DoGPyramid)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    [row,col,m]=size(DoGPyramid);
    for i=1:m
        [FX,FY]=gradient(DoGPyramid(:,:,i));
        [FXX,A]=gradient(FX);
        [B,FYY]=gradient(FY);  
        [C,FXY]=gradient(FX);
        [FYX,D]=gradient(FY);
        for j=1:row
            for k=1:col
                H=[FXX(j,k),FXY(j,k);FYX(j,k),FYY(j,k)];
                PrincipalCurvature(j,k,i)=(trace(H))^2/det(H);
            end
        end
    end
    
    
end
