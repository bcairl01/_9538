function P = reconstruct_path(p,ne)
    P = [];
    while true
        P(end+1)    = p(ne);
        ne          = p(ne);
        
        if ~ne
            break;
        end
    end
    P(end)=[];
end