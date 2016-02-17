% RANSACH.M
% 16-720 Spring 2015 - *Stub* Provided
% Generates a panorama of two images
%
% Arguments: 
%     im1  - first image
%     im2  - second image
%
% Returns: 
%     im3  - generated panorama
%
% usage: im3 = generatePanorama(im1, im2)

function im3 = generatePanorama(im1, im2)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    
    ratio=0.6; 
    
    image1=imread(im1);
    imgrey=rgb2gray(im2double(image1));
    image2=imread(im2);
    imgreytest=rgb2gray(im2double(image2));
    
    [locs1, desc1] = brief(imgrey);
    [locs2, desc2] = brief(imgreytest);   
    [matches] = briefMatch(desc1, desc2, ratio);
    
    nIter = 1500;
    tol = 1;
    [bestH, bestError, inliers] = ransacH(matches, locs1, locs2, nIter, tol);
    
    [row, col, ~] = size(image1); 
    left_bottom  = bestH * [0; 0; 1];    left_bottom  = left_bottom/left_bottom(3,1);
    left_top  = bestH * [0; row; 1];     left_top  = left_top/left_top(3,1);
    right_bottom = bestH * [col; 0;1];   right_bottom = right_bottom/right_bottom(3,1);
    right_top = bestH * [col; row;1];    right_top = right_top/right_top(3,1);
  

    a = [left_bottom,left_top,right_bottom,right_top];
    
    xmin = min(a(1, :));
    xmax = max(a(1, :));
    ymin = min(a(2, :));
    ymax = max(a(2, :));

    M = [1/(xmax/1280) 0 0;
         0 1/(xmax/1280) -ymin/(xmax/1280);
         0 0 1];
    out_size = [round((ymax - ymin)/(xmax/1280)), 1280];
    disp(out_size);

    warp_im1 = warpH(image1, M, out_size);
    warp_im2 = warpH(image2, M * bestH, out_size);
    
    warp_im1 = im2double(warp_im1);
    warp_im2 = im2double(warp_im2);
     
    mask = zeros(size(image1, 1), size(image1, 2));
    mask(1, :)=1; 
    mask(end, :)=1; 
    mask(:, 1)=1; 
    mask(:, end)=1;
    mask = bwdist(mask, 'city');
    mask = mask / max(mask(:));
    
    warp_im1_mask = warpH(mask, M, out_size);
    warp_im1_mask = repmat(warp_im1_mask, [1, 1], 3);
    warp_im2_mask = warpH(mask, M * bestH, out_size);
    warp_im2_mask = repmat(warp_im2_mask, [1, 1], 3);

    sum_mask = warp_im1_mask + warp_im2_mask;
    warp_im = (warp_im1_mask .* warp_im2 + warp_im2_mask .* warp_im1) ./sum_mask;
    
    warp_imf=warp_im2+warp_im1-warp_im;
    im3=warp_imf;
    imwrite(warp_imf, '../results/q5_2.jpg');
    imshow(warp_imf);
    

end
