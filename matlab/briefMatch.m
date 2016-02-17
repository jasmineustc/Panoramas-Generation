% BRIEFMATCH.M
% 16-720 Spring 2015 - *Stub* Provided
%   
% Arguments: 
%     desc1, desc2 - m-by-nbits, matrix of stacked BRIEF descriptors. 
%                    m is the number of valid descriptors. 
%                    desc1 is from the first image, desc2 is from the second
%     ratio        - Ratio value for the ratio test to suppress bad matches
% Returns: 
%     matches - p-by-2 matrix, where the first column are indices into desc1 
%               and the second column are indices into desc2.
% usage: [matches] = briefMatch(desc1, desc2, ratio)

function [matches] = briefMatch(desc1, desc2, ratio)
    % TODO: STUDENT IMPLEMENTATION GOES HERE
    matches=[];
    [m,nbits]=size(desc1);
    D=pdist2(desc1,desc2,'hamming');
    D=D*nbits;
    [D_r,D_c]=size(D);

    for i=1:D_r
        temp=sort(D(i,:));
        first=temp(1,1);
        second=temp(1,2);
        if(first<ratio*second)
            c1=find(D(i,:)==first);
            matches=[matches;i,c1];
        end
        
    end
    
    
end