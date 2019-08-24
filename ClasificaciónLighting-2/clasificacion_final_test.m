%% Fichero para la clasificacion del conjunto de test de la serie Lightning-2

%% Carga de ficheros del dataset
TEST_principal = load('../../UCR_TS_Archive_2015\Lighting2\Lighting2_TEST' );
TRAIN_principal = load('../../UCR_TS_Archive_2015\Lighting2\Lighting2_TRAIN' );
TRAIN_class_labels = TRAIN_principal(:,1); % Eliminamos las etiquetas de clase
TEST_class_labels = TEST_principal(:,1); % Eliminamos las etiquetas de clase 

%% Inicializacion de vectores utilizados posteriormente para calcular
% indicadores
valores_previstos = zeros (size(TEST_principal,2),1);
valores_obs = zeros (size(TEST_principal,2),1);
true_pos = 0;
true_neg = 0;
falso_pos = 0;
falso_neg = 0;

%% Inicializamos las caracteristicas y el criterio con la combinacion
% elegida
features_id = [1 4 28 31];
criterio_id = 5;

%% Switch en funcion de si tenemos 1,2,3 o 4 caracteristicas
switch size(features_id,2) 
    case 1
        feature1 = features_id(1);
        
        % Cargamos las caracteristicas de Train y Test del dataset de Lighting 2
        TRAIN = cargar_funcion_train(feature1);
        TEST = cargar_funcion_test(feature1);
		
        % Calculamos la longitud minima de las caracteristicas
		[row1, col1] = size(TEST);
		min_long = col1; 
		
    case 2
        feature1 = features_id(1);
        feature2 = features_id(2);
        
        % Cargamos las caracteristicas de Train y Test del dataset de Lighting 2
        TRAIN = cargar_funcion_train(feature1);
        TEST = cargar_funcion_test(feature1);
        TRAIN2 = cargar_funcion_train(feature2);
        TEST2 = cargar_funcion_test(feature2);
		
        % Calculamos la longitud minima de las caracteristicas
		[row1, col1] = size(TEST);
		[row2, col2] = size(TEST2);
		matriz_long = [col1 col2];
		min_long = min(matriz_long);
		
    case 3
        feature1 = features_id(1);
        feature2 = features_id(2);
        feature3 = features_id(3);
        
        % Cargamos las caracteristicas de Train y Test del dataset de Lighting 2
        TRAIN = cargar_funcion_train(feature1);
        TEST = cargar_funcion_test(feature1);
        TRAIN2 = cargar_funcion_train(feature2);
        TEST2 = cargar_funcion_test(feature2);
        TRAIN3 = cargar_funcion_train(feature3);
        TEST3 = cargar_funcion_test(feature3);
		
        % Calculamos la longitud minima de las caracteristicas
		[row1, col1] = size(TEST);
		[row2, col2] = size(TEST2);
		[row3, col3] = size(TEST3);
		matriz_long = [col1 col2 col3];
		min_long = min(matriz_long);
		
    case 4
        feature1 = features_id(1);
        feature2 = features_id(2);
        feature3 = features_id(3);
        feature4 = features_id(4);
        
        % Cargamos las caracteristicas de Train y Test del dataset de Lighting 2
        TRAIN = cargar_funcion_train(feature1);
        TEST = cargar_funcion_test(feature1);
        TRAIN2 = cargar_funcion_train(feature2);
        TEST2 = cargar_funcion_test(feature2);
        TRAIN3 = cargar_funcion_train(feature3);
        TEST3 = cargar_funcion_test(feature3);
        TRAIN4 = cargar_funcion_train(feature4);
        TEST4 = cargar_funcion_test(feature4);	
		
        % Calculamos la longitud minima de las caracteristicas
		[row1, col1] = size(TEST);
		[row2, col2] = size(TEST2);
		[row3, col3] = size(TEST3);
		[row4, col4] = size(TEST4);
		matriz_long = [col1 col2 col3 col4];
		min_long = min(matriz_long);
end

correct = 0; % Inicializamos el numero de aciertos

%% Bucle para recorrer todo el conjunto de test
for i = 1 : length(TEST_class_labels) 
    if size(features_id,2) == 1 % Si elegimos una sola caracteristica
		classify_this_object = TEST(i,:); % Obtenemos instancia
		this_objects_actual_class = TEST_class_labels(i); % Obtenemos la clase de la instancia
        
		% Montamos la matriz MLFS
		MLFS = classify_this_object;
		matriz_cov_MLFS = cov(MLFS');
        
        %Algoritmo para obtener la etiqueta predicha para esta instancia
        predicted_class = dame_etiqueta_test(TRAIN_class_labels, matriz_cov_MLFS, min_long,criterio_id, TRAIN);
        
        valores_previstos(i,1) = predicted_class; % Este vector almacena todas las predicciones           
        valores_obs(i,1) = this_objects_actual_class; % Este vector almacena todas las observaciones
        
        % Calculamos distintos indicadores
            if predicted_class == this_objects_actual_class 
                correct = correct + 1; % Total de aciertos
                if predicted_class == 1
                    true_pos =  true_pos + 1; % Total de verdaderos positivos
                else 
                    true_neg = true_neg + 1; % Total de verdaderos negativos
                end
            elseif predicted_class == 1
                    falso_pos = falso_pos + 1; % Total de falsos positivos
                else
                     falso_neg = falso_neg + 1; % Total de falsos negativos
                
            end
            
		disp([int2str(i), ' out of ', int2str(length(TEST_class_labels)), ' done']) % Reporte de progreso

    elseif size(features_id,2) == 2 % Si elegimos dos caracteristicas
		classify_this_object = TEST(i,:); % Obtenemos instancia 1
		classify_this_object2 = TEST2(i,:); % Obtenemos instancia 2
		this_objects_actual_class = TEST_class_labels(i); % Obtenemos la clase de la instancia
        
		% Montamos la matriz MLFS
		MLFS = [classify_this_object(1:min_long);classify_this_object2(1:min_long)];
		matriz_cov_MLFS = cov(MLFS');
        
        %Algoritmo para obtener la etiqueta predicha para esta instancia
		predicted_class = dame_etiqueta_test(TRAIN_class_labels, matriz_cov_MLFS, min_long,criterio_id, TRAIN,TRAIN2); 
        
        valores_previstos(i,1) = predicted_class; % Este vector almacena todas las predicciones           
        valores_obs(i,1) = this_objects_actual_class; % Este vector almacena todas las observaciones
        
        % Calculamos distintos indicadores
            if predicted_class == this_objects_actual_class 
                correct = correct + 1; % Total de aciertos
                if predicted_class == 1
                    true_pos =  true_pos + 1; % Total de verdaderos positivos
                else 
                    true_neg = true_neg + 1; % Total de verdaderos negativos
                end
            elseif predicted_class == 1
                    falso_pos = falso_pos + 1; % Total de falsos positivos
                else
                     falso_neg = falso_neg + 1; % Total de falsos negativos
                
            end
            
		disp([int2str(i), ' out of ', int2str(length(TEST_class_labels)), ' done'])  % Reporte de progreso 
        
    elseif size(features_id,2) == 3 % Si elegimos tres caracteristicas
		classify_this_object = TEST(i,:); % Obtenemos instancia 1
		classify_this_object2 = TEST2(i,:); % Obtenemos instancia 2
        classify_this_object3 = TEST3(i,:); % Obtenemos instancia 3
		this_objects_actual_class = TEST_class_labels(i);  % Obtenemos la clase de la instancia
        
		% Montamos la matriz MLFS
		MLFS = [classify_this_object(1:min_long);classify_this_object2(1:min_long);classify_this_object3(1:min_long)];
		matriz_cov_MLFS = cov(MLFS');
        
        %Algoritmo para obtener la etiqueta predicha para esta instancia
		predicted_class = dame_etiqueta_test(TRAIN_class_labels, matriz_cov_MLFS, min_long,criterio_id, TRAIN,TRAIN2,TRAIN3); 
        
        valores_previstos(i,1) = predicted_class; % Este vector almacena todas las predicciones           
        valores_obs(i,1) = this_objects_actual_class; % Este vector almacena todas las observaciones
        
        % Calculamos distintos indicadores
            if predicted_class == this_objects_actual_class 
                correct = correct + 1; % Total de aciertos
                if predicted_class == 1
                    true_pos =  true_pos + 1; % Total de verdaderos positivos
                else 
                    true_neg = true_neg + 1; % Total de verdaderos negativos
                end
            elseif predicted_class == 1
                    falso_pos = falso_pos + 1; % Total de falsos positivos
                else
                     falso_neg = falso_neg + 1; % Total de falsos negativos
            end
            
            disp([int2str(i), ' out of ', int2str(length(TEST_class_labels)), ' done'])  % Reporte de progreso 
            
    elseif size(features_id,2) == 4 % Si elegimos cuatro caracteristicas
		classify_this_object = TEST(i,:); % Obtenemos instancia 1
		classify_this_object2 = TEST2(i,:); % Obtenemos instancia 2
        classify_this_object3 = TEST3(i,:); % Obtenemos instancia 3
        classify_this_object4 = TEST4(i,:); % Obtenemos instancia 4
		this_objects_actual_class = TEST_class_labels(i); % Obtenemos la clase de la instancia
		
        % Montamos la matriz MLFS
		MLFS = [classify_this_object(1:min_long);classify_this_object2(1:min_long);classify_this_object3(1:min_long);classify_this_object4(1:min_long)];
		matriz_cov_MLFS = cov(MLFS');
		
        %Algoritmo para obtener la etiqueta predicha para esta instancia
        predicted_class = dame_etiqueta_test(TRAIN_class_labels, matriz_cov_MLFS, min_long,criterio_id, TRAIN,TRAIN2,TRAIN3,TRAIN4); 
        
        valores_previstos(i,1) = predicted_class; % Este vector almacena todas las predicciones           
        valores_obs(i,1) = this_objects_actual_class; % Este vector almacena todas las observaciones
        
        % Calculamos distintos indicadores
            if predicted_class == this_objects_actual_class 
                correct = correct + 1; % Total de aciertos
                if predicted_class == 1
                    true_pos =  true_pos + 1; % Total de verdaderos positivos
                else 
                    true_neg = true_neg + 1; % Total de verdaderos negativos
                end
            elseif predicted_class == 1
                    falso_pos = falso_pos + 1; % Total de falsos positivos
                else
                     falso_neg = falso_neg + 1; % Total de falsos negativos
            end
    end;
    
		disp([int2str(i), ' out of ', int2str(length(TEST_class_labels)), ' done']) % Reporte de progreso
end

%%%%%%%%%%%%%%%%% Creacion de reporte %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp(['El dataset que has probado tiene ', int2str(length(unique(TRAIN_class_labels))), ' clases']) 
disp(['El conjunto de entrenamiento tiene un tamaño de ', int2str(size(TRAIN_principal,1)),', y el de test tiene ',int2str(size(TEST_principal,1)),' instancias.']) 
disp(['La serie temporal es de longitud ', int2str(size(TRAIN_principal,2))]) 
disp(['La tasa de error fue del ',num2str((length(TEST_class_labels)-correct )/length(TEST_class_labels))]) 
disp(['La tasa de acierto fue del ',num2str((correct)/length(TEST_class_labels))])
disp(['El RMSE es del ',num2str(sqrt(sum((valores_previstos-valores_obs).^2)/61))])
disp(['La sensibilidad es ',num2str(true_pos/(true_pos+falso_neg))])
disp(['La especificidad es ',num2str(true_neg/(true_neg+falso_pos))])

%%%%%%%%%%%%%%%%% Fin del reporte %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 