function K = graph2geod(G,T)
    K = zeros(size(G));
    wb = waitbar(0,'Conversion...');
    for idx = 1:size(G,1)
       [d,~,~]  = graphshortestpath(G,idx);
       K(idx,:) = d-2*T;
       
       waitbar(idx/size(G,1))
    end
    delete(wb)
end