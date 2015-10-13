function [D,IDX] = generate_spatial_descriptors(mesh,percent,dmin,dmax,dres,type,varargin)

    G       = mesh2graph(mesh,2);
    N       = ceil(size(mesh.V,2)*percent);
    IDX     = ceil(linspace(1,size(mesh.V,2),N));
    D       = zeros(ceil((dmax-dmin)/dres),N);
    D_itr   = 0;
    
    if strcmpi(type,'GD')
        mode= 1;
    elseif strcmpi(type,'ED')
        mode= 2;
    else
        error('Unrecognized descriptor type.');
    end
    
    show_wb = 0;
    if numel(varargin)==1
        show_wb = ~strcmpi(varargin{1},'NOWAITBAR');
    end
    
    if show_wb
        wb = waitbar(0,'Descriptor generation (% Complete)');
    end
    for idx = IDX
        D_itr = D_itr + 1;
        if      mode==1
            [d,~,~] = graphshortestpath(G,idx);
        elseif  mode==2
            d       = nodedistances(mesh,idx);
        end
        tmp         = bin_values(d,dmin,dmax,dres);
        D(:,D_itr)  = tmp/size(G,2);
        pcomp       = idx/size(G,2);
        if show_wb
            waitbar(pcomp,wb,sprintf('Descriptor generation (%f percent complete)',pcomp*100));
        end
    end
    if show_wb
        delete(wb)
    end

end


function d = nodedistances(M,idx)
    diff = repmat(M.V(:,idx),1,size(M.V,2)) - M.V;
    d    = sum(diff.^2,1);
end
