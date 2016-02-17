clear all
format long
load('../data/tajPts.mat')
load('taj.mat');
p1 = tajPts(1:2,1:100);
p2 = tajPts(3:4,1:100);
pts=tajPts;
 image1='../data/taj1r.jpg';
 image2='../data/taj2r.jpg';
 
 [H2to1] = pano4_2(image1, image2, pts);
%  [row,col]=size(p1);
%  one=ones(1,col);
% %  [H2to1] = computeH(p1, p2);
% [H2to1] = computeH_norm(p1, p2);
% 
% new_pt=H2to1*[p2;one];
% new_p1=new_pt./repmat(new_pt(3,:),3,1);
% s=new_p1-[p1;one];











