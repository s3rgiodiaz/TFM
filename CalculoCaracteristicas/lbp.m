function codificaLBP = lbp (x)
    if ~isvector(x)
        error('Input must be a vector')
    else
        x1 = [x(2:end), x(end)];
        x1_aux = x > x1;
        x1_aux2 = x < x1;
        codificaLBP(1:2:length(x)*2-1)=x1_aux;
        codificaLBP(2:2:length(x)*2)=x1_aux2;
        codificaLBP(end-1:end)=[];
    end
end