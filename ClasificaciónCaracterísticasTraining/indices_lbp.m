%% Funcion para ajustar los indices del tamaño del numero de instancias al 
%% tamaño del fichero de lbp
function nuevos_indices = indices_lbp (vector_entrada,ventana)
    nuevos_indices = zeros (1,length(vector_entrada)*(ventana * 2 - 2));
    vector_aux = vector_entrada * (ventana * 2 - 2) - (ventana * 2 - 2);
    for punt = 1:length(vector_entrada)
        nuevos_indices((punt-1)*(ventana*2-2)+1:(punt-1)*(ventana*2-2)+ventana*2-2) = vector_aux(punt)+1:vector_aux(punt) + (ventana * 2 - 2);     
    end
end