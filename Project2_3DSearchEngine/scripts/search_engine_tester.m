% Search Engine Tester + PR Curve Generation

clear; clc;

% Tester params
plot_dir        = 'plots';
model_db        = 'models';
query_files     = getfilepaths('queries');
mquery_files    = getfilepaths('meta_queries');
model_files     = getfilepaths('meta_models');
N_models        = numel(model_files);
N_queries       = numel(mquery_files);
descript_names  = {'ED','GD','CD'};

% Pick some colors for plotting class PR Curves
colors          = colormap('jet');
colors          = colors(ceil(linspace(1,size(colors,1),tosca_size())),:);

mkdir(plot_dir);
for descript_ty = 1:3

    wb              = waitbar(0,'Testing...');
    populations     = zeros(tosca_size(),1);
    
    % Init PR Data structures
    r_avg           = zeros(N_models,1);
    p_avg           = zeros(N_models,1);
    r_class         = cell(tosca_size(),1);
    p_class         = cell(tosca_size(),1);
    for idx = 1:tosca_size()
        r_class{idx}= zeros(N_models,1);
        p_class{idx}= zeros(N_models,1);
    end

    
    
    for idx = 1:N_queries;
        query           = path2meshname(query_files{idx});
        class           = path2classname(query_files{idx});
        index           = tosca_index_dict(class);
        populations(index,1)     = populations(index,1) + 1;
        
        [m,~]           = search_engine(query,model_db,descript_ty);
        [p,r,H]         = prdat(m(:,1),class); 

        r_avg           = r_avg + r;
        p_avg           = p_avg + p;
        
        r_class{index}  = r_class{index} + r;
        p_class{index}  = p_class{index} + p;
        
        waitbar(idx/N_queries);
    end
    delete(wb);

    r_avg   = r_avg/N_queries;
    p_avg   = p_avg/N_queries;
    
    
    % Class-specific PR Curve
    figure(1)
        cla
        hold on
        for idx = 1:tosca_size()
            if ~populations(idx)
                r_class{idx} = [0,1];
                p_class{idx} = [0,0];
            else
                r_class{idx} = r_class{idx}/populations(idx);
                p_class{idx} = p_class{idx}/populations(idx);
            end
            plot(r_class{idx},p_class{idx},'Color',colors(idx,:));
        end
        [~,labels] = tosca_name_dict(1);
        legend(labels{:},'Location','northeastoutside')
        title(sprintf('PR Curve : %s-based Search Engine (by object class)',descript_names{descript_ty}))
        xlabel('Recall %')
        ylabel('Precision %')
        axis([0,1,0,1])
        hold off
    shg
    
    % Print PR class curve
    output_name = sprintf('%s/class_pr_%s',plot_dir,descript_names{descript_ty});
    print(output_name,'-dpng','-r300');
    
    % Average Descriptor PR Curve
    figure(2)
        cla
        h = plot(r_avg,p_avg);
        title(sprintf('PR Curve : %s-based Search Engine',descript_names{descript_ty}))
        xlabel('Recall %')
        ylabel('Precision %')
        axis([0,1,0,1])
    shg
    
    % Print PR Curve
    output_name = sprintf('%s/pr_%s',plot_dir,descript_names{descript_ty});
    print(output_name,'-dpng','-r300');
    
    % Save generated PR data
    save(output_name,'r_avg','p_avg','r_class','p_class');

end