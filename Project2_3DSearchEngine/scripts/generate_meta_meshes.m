% Generate meta-meshes for all query models
%
% --    Since the query set contains all of the database models, we will just
%       use the models generates from here and place them in the
%       mete_models folder
%
% --    Uses parallel worker capabilities for speedup


% Parallel computing setup
try
    matlabpool close
end
matlabpool(4)

% Original, raw meshes
src_folder = 'queries';


% Meshs with class/descriptor data and some nice methods
dst_folder = sprintf('meta_%s_2',src_folder);


% Generate the output directory, if it does not exists
mkdir(dst_folder);


% Load all the input filenames
model_paths = getfilepaths(src_folder);
N_to_proc   = numel(model_paths);
MODELS      = cell(N_to_proc,1);


% Do the file conversion
for idx = 1:N_to_proc
    
    tic
    fprintf('%s - started\n',model_paths{idx});
    MODELS{idx} = metamesh('FILE',model_paths{idx});
    fprintf('%s - completed in %f s\n',model_paths{idx},toc);

end
for idx = 1:N_to_proc
    mmesh       = MODELS{idx};
    dst_path    = sprintf('%s/%s.mat',dst_folder,mmesh.name);
    waitbar( idx/N_to_proc, wb );
    set(wb,'Name',sprintf('%s ==> %s ',model_paths{idx},dst_path));
    
    save(dst_path,'mmesh');
end


% Model query==models to meta_models

% Model database
db_folder = 'models';

% Meshs with class/descriptor data and some nice methods
dst_db_folder = sprintf('meta_%s_2',db_folder);

% Generate the output directory, if it does not exists
mkdir(dst_db_folder);

db_model_paths = getfilepaths(dst_folder);
for idx = 1:numel(db_model_paths)
    if nnz(db_model_paths{idx}=='_')<2
        copyfile( db_model_paths{idx}, dst_db_folder );
    end
end

% Stop parallel workers
matlabpool close;