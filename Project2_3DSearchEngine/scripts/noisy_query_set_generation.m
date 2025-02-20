%%% Generate Noisy Query Set
clear;
clc
input_dir  = 'models';
output_dir = 'high_noise_models'; 
noise_level= 0.015;


mkdir(output_dir);
dir_list = dir(input_dir);

wb = waitbar(0,'Completion : ');
for fidx = 1:numel(dir_list)
    input_path  = sprintf('%s/%s',input_dir, dir_list(fidx).name);
    output_path = sprintf('%s/%s',output_dir,dir_list(fidx).name );
    waitbar(fidx/numel(dir_list),wb,sprintf('Input %s',input_path));
    if  ismeshfilename(dir_list(fidx).name)
        addGaussianNoise(input_path,output_path,noise_level)
    end
end
delete(wb)