%% Ejemplo de calculo de la caracteristica varianza

%% Carga de fichero
SET = load('SeriesParaValidarFeatures\Varianza\SeriesValidarVarianza.dat');

%% Inicializacion de variables
SET_labels = SET(:,1); % Etiquetas de clase
tam_ventana = 17; % Longitud ventana 
varianza = zeros(length(SET_labels),length(SET(1,:))); %Creamos la matriz y la inicializamos con ceros

%% Bucle para recorrer todo el conjunto de datos
for i = 1 : length(SET_labels(:,1))

    classify_this_object = SET(i,2:end); % Cogemos cada instancia de la serie
    
    %% Calculo de la varianza
    varianza(i,1)= SET_labels(i,1); % Establecemos su etiqueta
        for j = 2 : length(classify_this_object)
            if j + tam_ventana < length(classify_this_object)
                varianza(i,j) = var(classify_this_object(j:j+tam_ventana-1));
            else
                varianza(i,j) = var(classify_this_object(j:end));
            end
        end   

end
 
%% Creamos un fichero con los datos de la caracteristica
csvwrite('VarianzaValidar.dat',varianza);