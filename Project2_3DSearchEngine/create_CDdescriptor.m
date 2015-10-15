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
function d  = create_CDdescriptor(M,varargin)
    
    % Defaults
    p       = 0.01;
    d_min   = -1;
    d_max   =  1;
    d_res   = 0.01;
    
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
    L = curvature(M,p);
    
    % Bin distances to form descriptor
    d = binvalues(L,d_min,d_max,d_res);
end


function P = curvature(M,p)
    
    L     = size(M.E,2);
    n     = ceil(L*p);
    N     = ceil(linspace(1,L,n));
    P     = zeros(n,L);
    PN    = faces2normals(M);
    NM    = PN(4:6,:).'*PN(4:6,:);
    P     = NM(N,:);
end