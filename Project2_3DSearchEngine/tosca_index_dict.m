function n = tosca_index_dict( class )
    if      strcmpi(class,'CAT')        ; n = 1;
    elseif  strcmpi(class,'CENTAUR')    ; n = 2;
    elseif  strcmpi(class,'DOG')        ; n = 3;
    elseif  strcmpi(class,'GORILLA')    ; n = 4;
    elseif  strcmpi(class,'HORSE')      ; n = 5;
    elseif  strcmpi(class,'LIONESS')    ; n = 6;
    elseif  strcmpi(class,'WOLF')       ; n = 7;
    elseif  strcmpi(class,'SEAHORSE')   ; n = 8;
    elseif  strcmpi(class,'VICTORIA')   ; n = 9;
    elseif  strcmpi(class,'MICHAEL')    ; n = 10;
    elseif  strcmpi(class,'DAVID')      ; n = 11;
    else
        error('Unknown model class.');
    end
end