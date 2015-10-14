function n = tosca_population_dict( class )
    if      strcmpi(class,'CAT')        ; n = 9;
    elseif  strcmpi(class,'CENTAUR')    ; n = 6;
    elseif  strcmpi(class,'DOG')        ; n = 11;
    elseif  strcmpi(class,'GORILLA')    ; n = 21;
    elseif  strcmpi(class,'HORSE')      ; n = 17;
    elseif  strcmpi(class,'LIONESS')    ; n = 15;
    elseif  strcmpi(class,'WOLF')       ; n = 3;
    elseif  strcmpi(class,'SEAHORSE')   ; n = 6;
    elseif  strcmpi(class,'VICTORIA')   ; n = 24;
    elseif  strcmpi(class,'MICHAEL')    ; n = 20;
    elseif  strcmpi(class,'DAVID')      ; n = 15;
    else
        error('Unknown model class.');
    end
end