function [D,IDX] = generate_spatial_descriptors(mesh,N,dmin,dmax,dres,type)

    [G,~,T] = mesh2graph(mesh,2);
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
    
    wb      = waitbar(0,'Descriptor generation (% Complete)');
    for idx = IDX
        D_itr = D_itr + 1;
        if      mode==1
            [d,p,~] = graphshortestpath(G,idx);
            dd      = 2*T.*get_path_counts(p) - d;
        elseif  mode==2
            dd      = nodedistances(mesh,idx);
        end
        tmp         = bin_values(dd,dmin,dmax,dres);
        D(:,D_itr)  = tmp/size(G,2);
        pcomp       = idx/size(G,2);
        waitbar(pcomp,wb,sprintf('Descriptor generation (%f percent complete)',pcomp*100));
    end
    delete(wb)

end


function d = nodedistances(M,idx)
    diff = repmat(M.V(:,idx),1,size(M.V,2)) - M.V;
    d    = sum(diff.^2,1);
end

function c = get_path_counts(p)
    c = zeros(1,numel(p));
    for idx = 1:numel(p)
        c(idx) = numel(p{idx});
    end
end