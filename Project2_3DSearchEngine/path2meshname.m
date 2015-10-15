% Generates a name for each .off mesh from its abolsute path wihtin root
% *** HELPER FUNCTION
% *** NON-GENERIC
function name = path2meshname(path)
    a       = find(path=='/',1);
    if isempty(a)
        a = 0;
    end
    b       = find((path=='.'));
    name    = path( (a+1):(b-1) );
end