function meshviewpath(M,P,varargin)
    hold on
    meshview(M,varargin{:});
    plot3(M.V(1,P),M.V(2,P),M.V(3,P),'r-','LineWidth',3);
    hold off
    axis equal
end