% [L,p] = DIJKSTRAS(G,b) 
%
% Computes the shortest path from a starting node to all other nodes.
%
% Input:
%   G       an adjacency graph (N x N)
%   b       starting node index
%
% Output:
%   L       length of path to each node from 'b'
%   p       pathing information (use 'RECOVER_PATH' to generate node-to-node path)
%
function [L,p] = dijkstras(G,b)
    
    N       = size(G,2);
    O       = ones(1,N);
    L       = ones(1,N)*inf;
    p       = zeros(1,N);
    
    % Set initial node to disttance of 0
    L(b)    = 0;
    V       = b;
    
    while ~isempty(V)
        
        % get neighbors
        edges       = find( (G(V(1),:)~=inf ) & O );
        Lp          = L(V(1)) + G(V(1),edges);
        qualified   = (Lp < L(edges));
        p_edges     = edges(qualified);
        L(p_edges)  = Lp(qualified);
        
        % add to open list
        V           = [V,p_edges]; %#ok<AGROW>
        
        if nargout==2
            p(p_edges) = V(1);
        end
        
        % set as visited
        O(V(1))     = 0;
        V(1)        = [];
        
    end
end