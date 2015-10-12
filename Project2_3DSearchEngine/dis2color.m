function C  = dis2color(D)
    D       = (D-min(D))/(max(D) - min(D));
    C       = zeros(numel(D),3);
    C(:,1)  = D;
    C(:,2)  = 1-D;
end