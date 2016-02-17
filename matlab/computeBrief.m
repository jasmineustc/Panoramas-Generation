% COMPUTEBRIEF.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     im                 - a grayscale image with range 0 to 1
%     locs               - keypoints from the DoG detector
%     levels             - Gaussian scale levels from Section 1
%     compareX, compareY - Linear indices into the image patch (nbits x 1)
% Returns: 
%     locs - m-by-3 matrix, where the first two columns are the image
%            coordinates of keypoints and the third column is the pyramid
%            level of the keypoints
%     desc - m-by-nbits, matrix of stacked BRIEF descriptors. 
%            m is the number of valid descriptors
% usage: [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)

function [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    [height,width]=size(im);
    newlocs=locs;
    locs=[];
    [row,col]=size(newlocs);
    for i=1:row
        if(newlocs(i,1)>4 && newlocs(i,1)<(height-4))
            if(newlocs(i,2)>4 && newlocs(i,2)<(width-4))
                locs=[locs;newlocs(i,:)];
            end
        end
    end
    
    [row,col]=size(locs);
    [nbits,c]=size(compareX);
    desc=zeros(row,nbits);
    
    for k=1:row
        temp_im=im((locs(k,1)-4):(locs(k,1)+4),(locs(k,2)-4):(locs(k,2)+4));
        for j=1:nbits
            rx=floor((compareX(j,1)-1)/9)+1;
            cx=mod(compareX(j,1),9)+1;
            ry=floor((compareY(j,1)-1)/9)+1;
            cy=mod(compareY(j,1),9)+1;
            if(temp_im(rx,cx)<temp_im(ry,cy))
                desc(k,j)=1;
            end
        end
    end
    
    
   
end