%   LOAD_META_DATABASE
%   Loads all meta models
%   *** HELPER FUNCTION
function D = load_meta_database(folder)
    filenames   = getfilepaths(folder);
    N           = numel(filenames);
    D           = cell(N,1);
    
    for idx = 1:N
       D{idx}   = load(filenames{idx});
    end
end