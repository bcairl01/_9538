function str = remove_between(str,start_str,end_str)
    str = str( (numel(start_str)+1):( strfind(str,end_str) - 1) );
end