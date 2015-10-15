% N = FACES2NORMALS(M)
%
% Coverts triangular all mesh faces to point-normal-vector (6 x 1) represention
function N = faces2normals(M)
    
    m = size(M.E,2);
    N = zeros(6,m);
    for mdx = 1:m
        va          =  M.V(:,M.E(2,mdx)) - M.V(:,M.E(3,mdx));
        vb          =  M.V(:,M.E(4,mdx)) - M.V(:,M.E(3,mdx));
        N(1:3,mdx)  = (M.V(:,M.E(2,mdx)) + M.V(:,M.E(3,mdx)) + M.V(:,M.E(4,mdx)))/M.E(1,mdx);
        N(4:6,mdx)  = cross(va,vb);
    end

end