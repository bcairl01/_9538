function [p,r,H] = prdat(ranked,query)
    
    M = tosca_population_dict(query);
    N = numel(ranked);
    H = zeros(N,1);
    r = zeros(N,1);
    p = zeros(N,1);
    for idx = 1:N
        H(idx,1) = strcmpi(ranked{idx,1},query);
        r(idx,1) = nnz(H)/M;
        p(idx,1) = nnz(H)/idx;
    end
end