%%% Incomplete Query Set
clear;
clc
input_dir  = 'models';
output_dir = 'low_incomplete_models'; 
keep_level = 0.9;


mkdir(output_dir);
dir_list = dir(input_dir);

wb = waitbar(0,'Completion : ');
for fidx = 1:numel(dir_list)
    input_path  = sprintf('%s/%s',input_dir, dir_list(fidx).name);
    output_path = sprintf('%s/%s',output_dir,dir_list(fidx).name );
    waitbar(fidx/numel(dir_list),wb,sprintf('Input %s',input_path));
    if  ismeshfilename(dir_list(fidx).name)
        M = meshread(input_path);
        M = passthrough(M,keep_level,2);
        meshwrite(M,output_path);
    end
end
delete(wb)