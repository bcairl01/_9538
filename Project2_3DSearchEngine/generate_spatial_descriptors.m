% [D,IDX] = generate_spatial_descriptors(mesh,percent,dmin,dmax,dres,type,...)
%
% Generates GD and ED descriptors
%
% Inputs:
%   mesh        An input mesh
%   percent     Percent of the mesh''s vertices to used in descriptor generation
%   dmin        Minimum binning distance
%   dmax        Maximum binning distance
%   dres        Binning resolution (step)
%   type        {ED|GD} descriptor type
%
% Output:
%   D           (ceil((dmax-dmin)/dres) - 1) by 1 descriptor vector.
%   IDX         selected vectices for feature generation
% 
%

function [D,IDX] = generate_spatial_descriptors(mesh,percent,dmin,dmax,dres,type,varargin)

    G       = mesh2graph(mesh,2);
    N       = ceil(size(mesh.V,2)*percent);
    IDX     = ceil(linspace(1,size(mesh.V,2),N));
    D       = zeros(ceil((dmax-dmin)/dres),1);
    D_itr   = 0;
    
    if strcmpi(type,'GD')
        mode= 1;
    elseif strcmpi(type,'ED')
        mode= 2;
    elseif strcmpi(type,'BC')
        mode= 3;
    else
        error('Unrecognized descriptor type.');
    end
    
    show_wb = 1;
    if numel(varargin)==1
        show_wb = ~strcmpi(varargin{1},'NOWAITBAR');
    end
    
    if show_wb
        wb = waitbar(0,'Descriptor generation (% Complete)');
    end
    for idx = IDX
        D_itr = D_itr + 1;
        
        if show_wb
            pcomp       = idx/size(G,2);
            waitbar(pcomp,wb,sprintf('Descriptor generation (%f percent complete)',pcomp*100));
        end
        
        if      mode==1
            % Get geodesic distances to all points for point(idx)
            [d,~,~] = graphshortestpath(G,idx);
        elseif  mode==2
            % Get euclidean distances to all points for point(idx)
            d       = nodedistances(mesh,idx);
        elseif  mode==3
            % Generate a custom BC descriptor
            D       = [];
            continue;
        end
        
        D(:,1) = D(:,1) + bin_values(d,dmin,dmax,dres);
        
    end
    
    % Normalize
    D(:,1)  = D(:,1)/size(G,2)/N;
    if show_wb
        delete(wb)
    end

end

% Caluclates the distance to all nodes from node(idx)
function d = nodedistances(M,idx)
    diff = repmat(M.V(:,idx),1,size(M.V,2)) - M.V;
    d    = sum(diff.^2,1);
end
