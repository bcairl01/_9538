function [desc,conf] = descdirread(desc_directory)
    dirf      = dir(desc_directory);
    dirf(1:2) = []; % NOT: '.' and '..'
    N         = numel(dirf)-1;
    desc      = cell(N,2);
    conf      = dlmread(sprintf('%s/param.conf',desc_directory));
    
    wb        = waitbar(0,sprintf('[%f%%] Loading.',0));
    for idx = 1:N
        desc{idx,2} = sprintf('%s/%s',desc_directory,dirf(idx).name);
        desc{idx,1} = load(desc{idx,2});
        
        waitbar(idx/N,wb,sprintf('[%f%%] Loading : %s',100*idx/N,desc{idx,2}));
    end
    delete(wb)
end