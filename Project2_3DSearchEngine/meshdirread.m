function M  = meshdirread(mesh_directory)
    dirf      = dir(mesh_directory);
    dirf(1:2) = []; % NOT: '.' and '..'
    N         = numel(dirf);
    M         = cell(N,2);
    
    wb        = waitbar(0,sprintf('[%f%%] Loading.',0));
    for idx = 1:N
        M{idx,2} = sprintf('%s/%s',mesh_directory,dirf(idx).name);
        M{idx,1} = meshread(M{idx,2});
        waitbar(idx/N,wb,sprintf('[%f%%] Loading : %s',100*idx/N,M{idx,2}));
    end
    delete(wb)
end