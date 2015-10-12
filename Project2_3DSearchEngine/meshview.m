function meshview(M,varargin)
    if numel(varargin)
        patch('Faces',M.E.','Vertices',M.V.',varargin{:})
    else
        patch('Faces',M.E.','Vertices',M.V.','FaceColor','b')
    end
    axis equal
end