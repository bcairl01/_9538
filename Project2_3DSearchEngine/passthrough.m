function M = passthrough(M,p,dim)
    b = [min(M.V(dim,:)),max(M.V(dim,:))];
    d = b(1) + p*(b(2)-b(1));
    r = find(M.V(dim,:) > d);
    
    rem_edge = [];
    for idx = 1:size(M.E,2)
        for jdx = 1:size(M.E,1)
            if  any(M.E(jdx,idx)==r)
                rem_edge(end+1) = idx; %#ok<AGROW>
                break;
            end
        end
    end
    M.E(:,rem_edge) = [];
end