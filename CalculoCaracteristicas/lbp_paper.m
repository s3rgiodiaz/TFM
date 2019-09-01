function codigoLBP = lbp_paper (x)
    if ~isvector(x)
        error('Input must be a vector')
    elseif length(x) == 1
            codigoLBP = 0;
    elseif mod(length(x),2) == 0
            x(end+1)=x(end);
            muestra_central = x(ceil(length(x)/2)); 
            x(ceil(length(x)/2))=[];
            valor = x > muestra_central;
            codigoLBP = bi2de(valor);
    else
            muestra_central = x(ceil(length(x)/2)); 
            x(ceil(length(x)/2))=[];
            valor = x > muestra_central;
            codigoLBP = bi2de(valor);
    end
end