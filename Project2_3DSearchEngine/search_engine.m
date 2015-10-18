function [matches,ranked,query] = search_engine(query_name,model_folder,type,varargin)
    
 
    % Some extra animation stuff to work with a gui
    handle_3d   = 0;
    handle_hist = 0;
    isfigure    = zeros(1,2);
    while numel(varargin)
        if      strcmpi(varargin{1},'3D_HANDLE');   handle_3d   = varargin{2};
        elseif  strcmpi(varargin{1},'HIST_HANDLE'); handle_hist = varargin{2};
        elseif  strcmpi(varargin{1},'3D_FIGURE');   handle_3d   = varargin{2}; isfigure(1) = true;
        elseif  strcmpi(varargin{1},'HIST_FIGURE'); handle_hist = varargin{2}; isfigure(2) = true;
        end
        varargin(1:2) = [];
    end
    
    
    % Load the query models form the meta-query database
    query           = load(sprintf('meta_queries/%s',query_name));
    
    
    % Load the models from the meta-model database
    model_db        = load_meta_database(sprintf('meta_%s',model_folder));
    N               = numel(model_db);
    distances       = zeros(3,N);
    
    
    % Compute distances between query and all engine database models
    if ~isempty(model_db)
        for idx = 1:numel(model_db)
            distances(:,idx) = dist(query.mmesh,model_db{idx}.mmesh);
            
            % Animates the search process
            animate_driver( query, model_db, idx, handle_3d, handle_hist, isfigure )
        end
    end
    
    % Sort on a particular descriptor distance {ED,GD,CD}
    idistances      = sum(distances(type,:),1); % make 1 x N
    [ranks, didx]   = sort( idistances );
    
    % Output meta-models in rank-order
    ranked  = cell(N,2);
    matches = cell(N,2);
    for idx = 1:numel(didx)
        matches{idx,1}    = model_db{didx(idx)}.mmesh.class;
        matches{idx,2}    = model_db{didx(idx)}.mmesh.name;
        
        ranked{idx,1}     = ranks(idx);
        ranked{idx,2}     = model_db{didx(idx)}.mmesh;
    end
    
     % Optional final Animation
    animate_driver( query, model_db, didx(1), handle_3d, handle_hist, isfigure )
end



function animate_driver( query, model_db, idx, handle_3d, handle_hist, isfigure)
    if  handle_3d   
        if  isfigure(1)
            figure(handle_3d)
            cla
            show(query.mmesh        ,'FACECOLOR','b');
            show(model_db{idx}.mmesh,'FACECOLOR','g');
        else
            cla
            show(query.mmesh        ,'HANDLE',handle_3d,'FACECOLOR','b');
            show(model_db{idx}.mmesh,'HANDLE',handle_3d,'FACECOLOR','g');                    
        end
        pause(1e-3)
    end
    if  handle_hist
        if isfigure(2)
            figure(handle_hist)
        else
            axes(handle_hist) %#ok<*LAXES>
        end
        subplot(3,1,1); cla; 
            hold on
            plot(query.mmesh.GD,            'Color','b');
            plot(model_db{idx}.mmesh.GD,    'Color','g');
            hold off
        subplot(3,1,2); cla; 
            hold on
            plot(query.mmesh.ED,            'Color','b');
            plot(model_db{idx}.mmesh.ED,    'Color','c');
            hold off
        subplot(3,1,3); cla; hold on
            plot(query.mmesh.CD,            'Color','b');
            plot(model_db{idx}.mmesh.CD,    'Color','m');
            hold off
        pause(1e-3)
    end
end