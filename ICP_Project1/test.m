clc;
clear all;
close all;

% Has all the test filenames
filenames = {...
    '2D_Line.mat',...
    '2D_Line_Noise.mat',...
    '3D_Cat.mat',...
    '3D_Cat_Noise.mat' ...
};
NF              = numel(filenames);


% Driver params
MinErrorTol     = 1e-4;
MaxIterations   = 100;
StepFactor      = -1;

% Used to store outputs
TR              = cell(1,NF);
TT              = cell(1,NF);

for idx = 1:NF
    
    % Load 'model' and 'source' data
    load(filenames{idx})
    
    % Call the ICP allignement function, store final translation/rotations
    [source_alligned,TR{idx},TT{idx},err] = icp( source, model, MinErrorTol, StepFactor, MaxIterations);
    fprintf('Error %f for %s\n',err,filenames{idx});
    
    % Plot the soure/ results for comparison
    f = figure(idx);
    set(f,'Name',filenames{idx})
    
    %...before
    subplot(1,2,1)
    if      size(source,1) == 2
        plot( source(1,:), source(2,:), 'r.', model(1,:), model(2,:), 'b.')
    elseif  size(source,1) == 3
        plot3( source(1,:), source(2,:), source(3,:), 'r.', model(1,:), model(2,:), model(3,:), 'b.')
    end
    axis equal
    title('Before Allignment')
    
    %...after
    subplot(1,2,2)
    if      size(source,1) == 2
        plot( source_alligned(1,:), source_alligned(2,:), 'r.', model(1,:), model(2,:), 'g.')
    elseif  size(source,1) == 3
        plot3( source_alligned(1,:), source_alligned(2,:), source_alligned(3,:), 'r.', model(1,:), model(2,:), model(3,:), 'g.')
    end
    axis equal
    title('After Allignment')
end