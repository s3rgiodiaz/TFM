%% Funcion valida_feature la cual utilizamos para conocer la tasa de error/acierto de las series 
%de nuestras caracteristicas y asi poder validarlas.

function valida_feature

clear all;clc;
warning off;
SET = load('SeriesParaValidarFeatures\Varianza\VarianzaValidar.dat');

TRAIN=SET(1:10,:); %Dividimos el set en training y test
TEST=SET(11:end,:);
TRAIN_class_labels = TRAIN(:,1); % Extraemos las etiquetas del set de entrenamiento 
TRAIN(:,1) = []; % Eliminamos las etiquetas de todas las instancias de entrenamiento
TEST_class_labels = TEST(:,1); % Extraemos las etiquetas del set de test 
TEST(:,1) = [];  %Eliminamos las etiquetas de todas las instancias de test

                   
tam_ventana = 17; %Tamaño de la ventana

%% Cargamos los ficheros con los datos

    varianza_Train = load (strjoin(strcat(directorio,{'Varianza_'},fich_train)));
    varianza_Test = load (strjoin(strcat(directorio,{'Varianza_'},fich_test)));

correct = 0; % Inicializamos el numero de aciertos

for i = 1 : length(TEST_class_labels) % Bucle para todo el conjunto de test
    this_objects_actual_class = TEST_class_labels(i); %Clase de esta instancia

    %% Montamos la matriz MLFS
    MLFS = [TEST(i,:)];
    
    %Matriz de covarianza. Trasponemos la matriz MLFS porque para matrices, la funcion
    %cov(x) de Matlab trata cada fila como una observacion y cada columna
    %como una variable. Nosotros lo hemos montado justo al reves.
    matriz_cov_MLFS = cov(MLFS');
	
	%Ejecutamos el algoritmo y comprobamos su etiqueta
    predicted_class = Classification_Algorithm(TRAIN_class_labels,matriz_cov_MLFS,tam_ventana,TRAIN);
	
    if predicted_class == this_objects_actual_class 
		correct = correct + 1;
    end;
	disp([int2str(i), ' de ', int2str(length(TEST_class_labels)), ' hecho']) % Reporte de avance 
end;

%%%%%%%%%%%%%%%%% Creacion de reporte %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp(['El dataset que has probado tiene ', int2str(length(unique(TRAIN_class_labels))), ' clases']) 
disp(['El conjunto de entrenamiento tiene un tamaño de ', int2str(size(TRAIN,1)),', y el de test tiene',int2str(size(TEST,1)),' instancias.']) 
disp(['La serie temporal es de longitud ', int2str(size(TRAIN,2))]) 
disp(['La tasa de error fue del ',num2str((length(TEST_class_labels)-correct )/length(TEST_class_labels))]) 
disp(['La tasa de acierto fue del ',num2str((correct)/length(TEST_class_labels))])

%profile report
%profile off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function predicted_class = Classification_Algorithm(TRAIN_class_labels,matriz,ventana,feature_N)

best_so_far = inf;  %Inicializamos la variable de comparacion a infinito

	for i = 1 : length(TRAIN_class_labels) % Recorremos todo el conjunto de instancias de entrenamiento
	
    MLFS_comparacion = [feature_N(i,:)];
    matriz_comparacion = cov(MLFS_comparacion'); % Creacion de matriz MLFS

    distance_Riemannian = sqrt(sum(log(eig(matriz\matriz_comparacion)).^2)); %Calculo de la distancia Riemanniana

	if distance_Riemannian < best_so_far
		predicted_class = TRAIN_class_labels(i);  
		best_so_far = distance_Riemannian;
	end
	
end;