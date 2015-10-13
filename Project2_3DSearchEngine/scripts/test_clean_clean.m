% Test Clean + Clean
clear;
clc;

n_retrieve                      = 5;
descriptor_type                 = {'GD','ED'};
query_dir_list                  = {'models','low_noise_models','med_noise_models','high_noise_models'};
result_output_dir               = 'match_results';

for qdx = 1:numel(query_dir_list)
    
    query_dir                   = query_dir_list{qdx};
    query_models                = meshdirread(query_dir);
    correct                     = 0;
    tp_data                     = zeros(numel(descriptor_type),size(query_models,1));
    classification_data         = cell(numel(descriptor_type), n_retrieve+1);
    exact_classification_data   = cell(numel(descriptor_type), n_retrieve+1);


    for ddx = 1:numel(descriptor_type)

        desc_dir            = sprintf('%s_data',descriptor_type{ddx});
        [descriptors,conf]  = descdirread(desc_dir);

        n                   = size(query_models,1);
        exact_correct       = 0;
        class_correct       = 0;

        for jdx = 1:n

            D = generate_spatial_descriptors( ...
                query_models{jdx,1},    ...
                conf(1)/2,              ...
                conf(2),                ...
                conf(3),                ...
                conf(4),                ...
                descriptor_type{ddx},   ...
                'NOWAITBAR'             ...
            );


            % Grade descriptor comparions
            G = zeros(size(descriptors,1),1);
            m = size(descriptors,1);
            for kdx = 1:m
                G(kdx) = match_descriptors( descriptors{kdx,1}.D , D );
            end

            % Sort match grades
            [~,MDX] = sort(G);

             % Get model class names
            exact_query_name = remove_between( query_models{jdx,2} ,[query_dir,'/'],'.off');
            class_query_name = remove_trailing_num(exact_query_name);


            fprintf('[%d/%d] {%s-Descriptor} : %s : \n',...
                jdx,n,                              ...
                descriptor_type{ddx},               ...
                query_models{jdx,2}                 ...
            )

            % Store Query data 
            classification_data{jdx,1}          = class_query_name;
            exact_classification_data{jdx,1}    = exact_query_name;
            for ndx = 1:n_retrieve

                 % Get match class name
                exact_match_name = remove_between( descriptors{MDX(ndx),2} ,[desc_dir,'/',descriptor_type{ddx},'_'],'.mat');
                class_match_name = remove_trailing_num(exact_match_name);

                % Store classification data
                classification_data{jdx,ndx+1}          = class_match_name;
                exact_classification_data{jdx,ndx+1}    = exact_match_name;

                % Count true-positives
                if strcmpi(class_query_name,class_match_name)
                    tp_data(ddx,jdx) = tp_data(ddx,jdx) + 1;

                    fprintf('\t  %s ==> %s  \n',exact_match_name,exact_query_name);
                else
                    fprintf('\t {%s ==> %s} \n',exact_match_name,exact_query_name);
                end

            end
            fprintf('\t [%d/%d]\n',tp_data(ddx,jdx),n_retrieve);

        end
    end
    
    % Save this data
    save( sprintf('%s/%s_results',result_output_dir,query_dir),'classification_data','exact_classification_data','tp_data');
end