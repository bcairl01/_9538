function g = match_descriptors(D1,D2)
    [~,d]   = knnsearch(D1.',D2.');
    g       = mean(d);
end