% clear all

soure='../data/model_chickenbroth.jpg';
testsource='../data/chickenbroth_01.jpg';

im=imread(soure);
imgrey=rgb2gray(im2double(im));

im=imread(testsource);
imgreytest=rgb2gray(im2double(im));

sigma0=1;
k=2^0.5;
levels = [-1,0,1,2,3,4];
thr=12;
thcontrast=0.03;
patchWidth=9;
nbits=256;
ratio=0.8;
[locs1, desc1] = brief(imgrey);


counter=[];


for i=0:18
    imtestitself=imrotate(imgrey,i*10);    
    [locs2, desc2] = brief(imtestitself);
    [matches] = briefMatch(desc1, desc2, ratio);
    [row,col]=size(matches);
    counter=[counter;row,i];
    figure(i+1);
    plotMatches(imgrey, imtestitself, matches, locs1, locs2);
end

x = [0:10:180]';
bar(x,counter(:,1),0.5,'red');
axis([-10 190 0 300]); 
set(gca,'xtick',0:10:180);
xlabel('degree'),ylabel('number of correct match');  

 
 
 
 
