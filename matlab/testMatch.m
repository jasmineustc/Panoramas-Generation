% 
%
%

clear all

soure='../data/model_chickenbroth.jpg';
testsource='../data/chickenbroth_0';
form=['.jpg'];

im=imread(soure);
imgrey=rgb2gray(im2double(im));

sigma0=1;
k=2^0.5;
levels = [-1,0,1,2,3,4];
thr=12;
thcontrast=0.03;
patchWidth=9;
nbits=256;
ratio=0.6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  test chickenbroth pictures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[locs1, desc1] = brief(imgrey);


for i=1:5
   test=strcat(testsource, num2str(i), form);
   testname=fullfile(test);
   im=imread(testname);
   imgreytest=rgb2gray(im2double(im));  
   [locs2, desc2] = brief(imgreytest);
   [matches] = briefMatch(desc1, desc2, ratio);
   figure(i);
   plotMatches(imgrey, imgreytest, matches, locs1, locs2);
   [r,c]=size(matches);
   printmessage=strcat(testname,' has',num2str(r),' plots match with modle_chickenbroth.jpg\n');
   fprintf(printmessage);
 
end
counter=i;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  test pf* pictures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sourepf='../data/pf_scan_scaled.jpg';
testsourcepf={'../data/pf_desk.jpg';
            '../data/pf_floor_rot.jpg';
            '../data/pf_floor.jpg';
            '../data/pf_pile.jpg';
    };

im=imread(sourepf);
imgrey=im2double(im);

[locs1, desc1] = brief(imgrey);

for i=1:4
    im=imread(testsource{i,1});
    imgreytest=rgb2gray(im2double(im));
    [locs2, desc2] = brief(imgreytest);
    [matches] = briefMatch(desc1, desc2, ratio);
    figure(i+counter);
    plotMatches(imgrey, imgreytest, matches, locs1, locs2);
    [r,c]=size(matches);
    printmessage=strcat(testsource{i,1},' has ',num2str(r),' plots match with pf_scan_scaled.jpg\n');
    fprintf(printmessage);
end
  
counter=counter+i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  test taj1r and taj2r pictures
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

souretaj='../data/taj1r.jpg';
testsource_taj={'../data/taj2r.jpg';};

im=imread(souretaj);
imgrey=rgb2gray(im2double(im));

[locs1, desc1] = brief(imgrey);

im=imread(testsource_taj{1,1});
imgreytest=rgb2gray(im2double(im));

[locs2, desc2] = brief(imgreytest);
[matches] = briefMatch(desc1, desc2, ratio);
figure(counter+1);
plotMatches(imgrey, imgreytest, matches, locs1, locs2);
[r,c]=size(matches);
printmessage=strcat(testsource_taj{1,1},' has ',num2str(r),' plots match with taj1r.jpg\n');
fprintf(printmessage);
save('matches.mat','locs1','locs2','desc1','desc2','matches');






 









