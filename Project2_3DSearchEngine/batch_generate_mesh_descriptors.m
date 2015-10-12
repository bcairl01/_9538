function batch_generate_mesh_descriptors(input_dir,output_dir,percent,dmin,dmax,dres,type)
    mkdir(output_dir);
    dlmwrite(sprintf('%s/param.conf',output_dir),[percent,dmin,dmax,dres]);
    dir_list = dir(input_dir);
    for fidx = 1:numel(dir_list)
        input_path  = sprintf('%s/%s',input_dir,dir_list(fidx).name);
        output_path = sprintf('%s/%s_%s',output_dir,type,dir_list(fidx).name( 1:(end-4) ) );
        if  ismeshfilename(dir_list(fidx).name)
            M = meshread(input_path);
            D = generate_spatial_descriptors(M,percent,dmin,dmax,dres,type);
            save( output_path , 'D');
        end
    end
end