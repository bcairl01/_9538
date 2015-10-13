function meshwrite(M,filename)
    fid = fopen(filename,'w');
    
    fprintf(fid,'OFF\n');
    fprintf(fid,'%d %d 0\n',size(M.V,2),size(M.E,2));
    
    for idx = 1:size(M.V,2)
        fprintf(fid,'%f %f %f\n',M.V(1,idx),M.V(2,idx),M.V(3,idx));
    end
    
    for idx = 1:size(M.E,2)
        fprintf(fid,'3 %d %d %d\n',M.E(1,idx),M.E(2,idx),M.E(3,idx));
    end
    
    fclose(fid);
end