% PANO4_2.M
% 16-720 Spring 2015 - *Stub* Provided
% Computes the best fit homography matix in the least-squares sense.
% Warps img2 and img1 to a third frame, display warped version of img2, overlay both images
% 
% Arguments: 
%     img1  - first image
%     img2  - second image
%     pts   - 4x1048 matrix containing coordianates of feature points
%             first 2 columns are for img1, second 2 columns are for img2
% Returns: 
%     H2to1 - 3x3 homography matrix computed from img1 and img2. It is the best
%             fit given pts from img1 and img2 in the least-squares sense.
%
% usage: [H2to1] = pano4_2(img1, img2, pts)

function [H2to1] = pano4_2(img1, img2, pts)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    im1=imread(img1);
    im2=imread(img2);
    load('../results/q4_1.mat');

    [row, col, ~] = size(im1); 
    left_bottom  = H2to1 * [0; 0; 1];    left_bottom  = left_bottom/left_bottom(3,1);
    left_top  = H2to1 * [0; row; 1];     left_top  = left_top/left_top(3,1);
    right_bottom = H2to1 * [col; 0;1];   right_bottom = right_bottom/right_bottom(3,1);
    right_top = H2to1 * [col; row;1];    right_top = right_top/right_top(3,1);
  

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

    warp_im1 = warpH(im1, M, out_size);
    warp_im2 = warpH(im2, M * H2to1, out_size);
    
    warp_im1 = im2double(warp_im1);
    warp_im2 = im2double(warp_im2);
     
    mask = zeros(size(im1, 1), size(im1, 2));
    mask(1, :)=1; 
    mask(end, :)=1; 
    mask(:, 1)=1; 
    mask(:, end)=1;
    mask = bwdist(mask, 'city');
    mask = mask / max(mask(:));
    
    warp_im1_mask = warpH(mask, M, out_size);
    warp_im1_mask = repmat(warp_im1_mask, [1, 1], 3);
    warp_im2_mask = warpH(mask, M * H2to1, out_size);
    warp_im2_mask = repmat(warp_im2_mask, [1, 1], 3);

    sum_mask = warp_im1_mask + warp_im2_mask;
    warp_im = (warp_im1_mask .* warp_im2 + warp_im2_mask .* warp_im1) ./sum_mask;
    
    warp_imf=warp_im2+warp_im1-warp_im;
    imwrite(warp_imf, '../results/q4_2_pan.jpg');
    imshow(warp_imf);
    H2to1 = H2to1;

end












