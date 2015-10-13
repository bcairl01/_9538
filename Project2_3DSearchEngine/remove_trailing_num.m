function str = remove_trailing_num(str)
    while (str(end)>='0')&&(str(end)<='9'); str(end)=[]; end
end