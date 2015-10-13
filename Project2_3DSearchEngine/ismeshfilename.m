function b = ismeshfilename(fname)
    b = false;
    if  numel(fname)>3 && strcmpi( fname( (end-3):end ),'.OFF')
        b = true;
    end
end