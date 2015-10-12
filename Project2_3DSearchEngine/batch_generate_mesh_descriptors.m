function batch_generate_mesh_descriptors(input_dir,output_dir,N,dmin,dmax,dres,type)
    mkdir(output_dir);
    dlmwrite(sprintf('%s/param.conf',output_dir),[N,dmin,dmax,dres]);
    dir_list = dir(input_dir);
    for fidx = 1:numel(dir_list)
        if  ismeshfilename(dir_list(fidx).name)
            M = meshread(sprintf('%s/%s',input_dir,dir_list(fidx).name));
            D = generate_spatial_descriptors(M,N,dmin,dmax,dres,type);
            save( sprintf('%s/%s_%s.desc',output_dir,type,dir_list(fidx).name( 1:(end-4) ) ), 'D');
        end
    end
end