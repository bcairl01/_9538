function g = match_descriptors(D1,D2)

    % Using knn for genericness
    %   -   in the single feature case this is a simple L2-norm of the
    %       difference between 
    %   -   in the multi-descriptor case, this is a sample-consensus (SAC)
    [~,d] = knnsearch(D1.',D2.');
    
    % Get the mean distance (SAC)
    g     = mean(d);
end