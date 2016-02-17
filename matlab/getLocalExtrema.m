% DOGDETECTOR.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     DoGPyramid         - Matrix of size (height x width x m)
%     DoGLevels          - Vector with m elements
%     PrincipalCurvature - Matrix of size (height x width x m)
%     th_contrast        - scalar threshold for DoG image
%     th_r               - scalar threshold for principal curvature
% Returns: 
%     locs - N-by-3 matrix where N is the number of local extrema found and
%            each row contains the (x,y) position and the corresponding
%            DoGLevel number. 
%
% usage: locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)

function locs = getLocalExtrema(DoGPyramid, DoGLevels, ... 
                                PrincipalCurvature, th_contrast, th_r)
                            
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    locs=[];
    [row,col,m]=size(DoGPyramid);
    
    for k=1:m
         regmax = imregionalmax(DoGPyramid(:,:,k),8);
         regmin = imregionalmin(DoGPyramid(:,:,k),8);
         
        for i=1:row
            for j=1:col
                if k==1
                    temp=[DoGPyramid(i,j,k),DoGPyramid(i,j,k+1)];
                    regscalemax=imregionalmax(temp);
                    regscalemin=imregionalmin(temp);
                elseif k==m
                    temp=[DoGPyramid(i,j,k),DoGPyramid(i,j,k-1)];
                    regscalemax=imregionalmax(temp);
                    regscalemin=imregionalmin(temp);
                else
                    temp=[DoGPyramid(i,j,k-1),DoGPyramid(i,j,k),DoGPyramid(i,j,k+1)];
                    regscalemax=imregionalmax(temp);
                    regscalemin=imregionalmin(temp);
                end
                
                if abs(DoGPyramid(i,j,k))>th_contrast 
                    if abs(PrincipalCurvature(i,j,k))<th_r
                        if (regmax(i,j) == 1)|| (regmin(i,j)==1) 
                            if k==1
                                if regscalemax(1,1)==1 || regscalemin(1,1)==1
                                   locs=[locs;i,j,k];
                                end
                            elseif k==m
                                if regscalemax(1,1)==1 || regscalemin(1,1)==1
                                    locs=[locs;i,j,k];
                                end
                            else
                                if regscalemax(1,2)==1 || regscalemin(1,2)==1
                                    locs=[locs;i,j,k];
                                end
                            end                                                                 
                        end
                    end
                end
            end
         end
    end
    
end
