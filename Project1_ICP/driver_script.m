clear;
clc;
close all;


% Test files
filenames = {...
    '2D_Line.mat',...
    '2D_Line_Noise.mat',...
    '3D_Cat.mat',...
    '3D_Cat_Noise.mat' ...
};


% ICP function params
MinErrorTol     = 1e-3;
MaxIterations   = 20;
StepFactor      = -1;


NF              = numel(filenames);
TR              = cell(1,NF);
TT              = cell(1,NF);

for idx = 1:NF

    load(filenames{idx})

    [source_alligned,TR{idx},TT{idx}] = icp( source, model, MinErrorTol, StepFactor, MaxIterations);

    
    f = figure(idx);
    set(f,'Name',filenames{idx})
    
    subplot(1,2,1)
    if      size(source,1) == 2
        plot( source(1,:), source(2,:), 'r.', model(1,:), model(2,:), 'b.')
    elseif  size(source,1) == 3
        plot3( source(1,:), source(2,:), source(3,:), 'r.', model(1,:), model(2,:), model(3,:), 'b.')
    end
    axis equal
    title('Before Alignment')
    
    subplot(1,2,2)
    if      size(source,1) == 2
        plot( source_alligned(1,:), source_alligned(2,:), 'r.', model(1,:), model(2,:), 'g.')
    elseif  size(source,1) == 3
        plot3( source_alligned(1,:), source_alligned(2,:), source_alligned(3,:), 'r.', model(1,:), model(2,:), model(3,:), 'g.')
    end
    axis equal
    title('After Alignment')
end