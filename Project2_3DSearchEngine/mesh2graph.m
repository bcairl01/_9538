% [G,D] = mesh2graph(M,p)
%  
% Generates a weighted adjacency matrix from a mesh structures with elements
%
%   M.V = vertices  3 x N
%   M.E = edges     3 x M
$
$ Inputs:
%   M   mesh
%   p   Lp norm order
$
$ Outputs:
%   G   sparse adjacency matrix
%   D   distance matrix


function [G,D] = mesh2graph(M,p)
    D = ones( size(M.V,2) )*inf;
    G = zeros( size(M.V,2));
    
    for idx = 1:size(M.E,2)
        for jdx = 1:3
            a = M.E(jdx,idx);
            for kdx = 1:3
                if  kdx~=jdx
                    b = M.E(kdx,idx);
                    d = norm( M.V(:,a)- M.V(:,b), p);
                    D(a,b) = d;
                    D(b,a) = d;
                end
            end
        end
    end
    
    ninf    = (D~=inf);
    G(ninf) = D(ninf);
    G       = sparse(G);
end