% MAKETESTPATTERN.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     patchWidth - Width of image patch (usually 9)
%     nbits      - Number of tests in the BRIEF descriptor (usually 256)

% Returns: 
%     compareX, compareY - Linear indices into the image patch (nbits x 1)
%
% usage: [compareX, compareY] = makeTestPattern(patchWidth, nbits)
function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    pixel=patchWidth*patchWidth;
    X=randperm(pixel*pixel,nbits);
    compareX=(floor(X/pixel)+1)';
    compareY=mod(X,pixel)'+1;

    
    save('testPattern.mat','compareX','compareY');
%
end