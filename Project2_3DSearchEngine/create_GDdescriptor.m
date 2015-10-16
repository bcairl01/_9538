% d  = CREATE_GDDESCRIPTOR(M,...)
%
% Generates a GD-descriptor vector for the mesh M
%
% Input:
%   M       source mesh
%
% Output:
%   d       GD-descriptor vector
%
function d  = create_GDdescriptor(M,varargin)
    
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
    L = geodesic(M,p);
    
    % Bin distances to form descriptor
    d = binvalues(L,d_min,d_max,d_res);
end


% P = GEODESIC(M,p)
%
% Generates the geodesic distance from 'p' percent of the vertices in mesh M
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
function P = geodesic(M,p)
    
    L     = size(M.V,2);
    n     = ceil(L*p);
    N     = ceil(linspace(1,L,n));
    P     = zeros(n,L);
    G     = mesh2graph(M,2);
    
    for ndx = 1:n
        P(ndx,:) = dijkstras(G,N(ndx));
    end
end