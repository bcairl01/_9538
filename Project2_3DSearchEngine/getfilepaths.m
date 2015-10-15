% GETFILEPATHS(folder)
% 
% Gets the relative path of all files within a folder
%
function paths      = getfilepaths(folder)
    directory       = dir(folder);
    directory(1:2)  = [];
    
    N               = numel(directory);
    paths           = cell(N,1);
    for idx = 1:numel(directory)
        paths{idx}  = sprintf('%s/%s',folder,directory(idx).name);
    end
end