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

function c = bin_values(d,min,max,res)
    N    = numel(d);
    LTM  = repmat(transpose(min:res:(max-res)),1,N);
    GTM  = repmat(transpose((min+res):res:max),1,N);
    M    = size(GTM,1);
    D    = repmat(d,M,1);
    C    = (D>LTM)&(D<=GTM);
    c    = sum(C,2);
end