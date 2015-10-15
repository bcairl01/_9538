% c = bin_values(d,min,max,res)
%
% Generates a historgram vector 'c' with ceil((max-min)/res)-1 elements
%
% Input:
%	d 	 	vector of values to count
% 	min 	minimum binning value
% 	max 	maximum binning value
% 	res 	the size of each bin
%
% Output:
% 	c 		output historgram

function c = binvalues(D,min,max,res)
    [M,N]   = size(D);
    L       = floor((max-min)/res);
    c       = zeros(L,1);
    
    for mdx = 1:M
        LTM     = repmat(transpose(min:res:(max-res)),1,N);
        GTM     = repmat(transpose((min+res):res:max),1,N);
        DD      = repmat(D(mdx,:),L,1);
        C       = (DD>LTM)&(DD<=GTM);
        c       = c + sum(C,2);
    end
    c = c/M;
end