% Generates a class for each .off mesh from its abolsute path wihtin root
% *** HELPER FUNCTION
% *** NON-GENERIC
function name = path2classname(path)
    a       = find(path=='/',1);
    if isempty(a)
        a = 0;
    end
    b       = find( (path>='0') & (path<='9') );
    name    = path( (a+1):(b(1)-1) );
end