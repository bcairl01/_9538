% Generate meta-meshes for all query models
% --    Since the query set contains all of the database models, we will just
%       use the models generates from here and place them in the
%       mete_models folder


% Original, raw meshes
src_folder = 'queries';

% Meshs with class/descriptor data and some nice methods
dst_folder = sprintf('meta_%s',src_folder);


% Generate the output directory, if it does not exists
mkdir(dst_folder);


% Load all the input filenames
model_paths = getfilepaths(src_folder);
N_to_proc   = numel(model_paths);


% Do the file conversion
wb = waitbar(0,'Progress');
for idx = 1:N_to_proc
    mmesh       = metamesh('FILE',model_paths{idx});
    dst_path    = sprintf('%s/%s.mat',dst_folder,mmesh.name);
    
    waitbar( idx/N_to_proc, wb );
    set(wb,'Name',sprintf('%s ==> %s ',model_paths{idx},dst_path));
    
    save(dst_path,'mmesh');
end