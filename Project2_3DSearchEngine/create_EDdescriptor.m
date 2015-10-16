% d  = CREATE_EDDESCRIPTOR(M,...)
%
% Generates a ED-descriptor vector for the mesh M
%
% Input:
%   M       source mesh
%
% Output:
%   d       GD-descriptor vector
%
function d  = create_EDdescriptor(M,varargin)
    
    % Defaults
    p       = 0.1;
    d_min   = 0;
    d_max   = 600;
    d_res   = 1;
    
    % Process variable arguments
    while numel(varargin)
        if      strcmpi(varargin{1},'PSAMPLE'); p     = varargin{2};
        elseif  strcmpi(varargin{1},'DMIN');    d_min = varargin{2};
        elseif  strcmpi(varargin{1},'DMAX');    d_max = varargin{2};
        elseif  strcmpi(varargin{1},'DRES');    d_res = varargin{2};
        else
            error(['Unknown parameter : ',varargin{1}]);
        end
        varargin(1:2) = [];
    end
    
    % Generate geodesic distances
    L = euclidean(M,p);
    
    % Bin distances to form descriptor
    d = binvalues(L,d_min,d_max,d_res);
end


% P = EUCLIDEAN(M,p)
%
% Generates the eculidean distance from 'p' percent of the vertices in mesh M
% to all other vertices in M.
%
% Input:
%   M       mesh (with elements M.V and M.E)
%   p       percentage of vertices to sample
%
% Output:
%   P       M x N matrix of goedesic distances where N is the number of
%           vertices in N and M=N*p is the number of sampled points.
%
function P = euclidean(M,p)
    
    L     = size(M.V,2);
    n     = ceil(L*p);
    N     = ceil(linspace(1,L,n));
    P     = zeros(n,L);

    for ndx = 1:n
        P(ndx,:) = euclidean_row(M,N(ndx));
    end
end
function er = euclidean_row(M,i)
    diff = M.V - repmat(M.V(:,i),1,size(M.V,2));
    er   = sqrt( sum( diff.^2, 1 ) );
end