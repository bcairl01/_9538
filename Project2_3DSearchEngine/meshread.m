function M = meshread(filename)
    
    fid = fopen(filename);
    M.V = [];
    M.E = [];
    if fid > 0
        header      = fgets(fid,3);
        
        if  strcmpi(header,'OFF')
            line        = fscanf(fid,'%d');
            n_verts     = line(1);
            n_edges     = line(2);
            
            if ~line(3)
            
                M.V     = zeros(3,n_verts);
                M.E     = zeros(4,n_edges);

                itr     = 0;
                while itr < n_verts
                    itr         = itr + 1;
                    M.V(:,itr)  = fscanf(fid,'%f',3);
                end

                itr     = 0;
                while itr < n_edges
                    itr         = itr + 1;
                    M.E(:,itr)  = fscanf(fid,'%d',4)+1;
                end  
            end
        end
        fclose(fid);
        M.E(1,:) = [];
    else
       warning(['No file : ',filename]); 
    end
end