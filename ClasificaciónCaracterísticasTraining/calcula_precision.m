%% Función calcula_precisión. Habría que pasarle los bloques de entrenamiento y test
%  además del criterio, los índices del baraje, los bloques en los que se han dividido todas las instancias,
% el id del bloque de test y las características a probar
% Devolvería la precisión obtenida por el algoritmo
function [precision]= calcula_precision(train,test,criterio,indices_baraje,npartes,parte_test,features)
    warning('OFF');
        
    if nargin==0 
       error('No ha introducido ningun argumento')
    else   

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        TRAIN_class_labels = train(:,1); % Pull out the class labels. 
        %TRAIN(:,1) = []; % Remove class labels from training set. 
        TEST_class_labels = test(:,1); % Pull out the class labels. 
        %TEST(:,1) = []; % Remove class labels from testing set.

        %% Variables para cambiar directorio
        %directorio = '../DatosLight2/';
        %fich_train = 'Lighting2_Train.dat';
        tam_ventana = 17; %Tamaño de la ventana


        switch size(features,2) %Switch en función de si tenemos 2,3 o 4 características
            case 1

                feature1 = features(1);
                feature1_train = cargar_funcion(feature1);  %Cargamos la característica calculada correspondiente
                
                if find(features == 9)   %La feature 1 es LBP 
                        
                        indices_nuevos = indices_lbp(indices_baraje,tam_ventana); %Reconfiguramos los indices para la feature de LBP
                        feature1_train = feature1_train(indices_nuevos,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,size(feature1_train,2),tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1);

                else    %Si no aparece LBP

                        feature1_train = feature1_train(indices_baraje,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision(TEST_class_labels,TRAIN_class_labels,size(feature1_train,2),tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1);
                end
                
                switch criterio
                    case 1
                        precision = (correct/length(TEST_class_labels));                      
                    case 2
                        precision = (length(TEST_class_labels) - correct)/length(TEST_class_labels);
                    case 3
                        precision = f_pos;
                    case 4
                        precision = f_neg;
                    case 5
                        precision = (correct/length(TEST_class_labels));
                    case 6
                        precision = (correct/length(TEST_class_labels));
                    case 7
                        precision = t_pos;
                    case 8
                        precision = t_neg;
                end

                              
            case 2
                feature1 = features(1); feature2 = features(2);
                feature1_train = cargar_funcion(feature1); %Cargamos la característica calculada correspondiente
                feature2_train = cargar_funcion(feature2); %Cargamos la característica calculada correspondiente
                
                [row1, col1] = size(feature1_train);
                [row2, col2] = size(feature2_train);
                matriz_long = [col1 col2];
                min_long = min(matriz_long); % Longitud mínima de las características

                     if find(features == 9)
                         if row1 > row2 %La feature 1 es LBP
                            indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                            feature1_train = feature1_train(indices_nuevos,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            feature2_train = feature2_train(indices_baraje,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2);
                         else % Sino LBP es la feature 2
                            feature1_train = feature1_train(indices_baraje,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);                             
                            indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                            feature2_train = feature2_train(indices_nuevos,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_2,valores_feature_training_2,valores_feature_test_1,valores_feature_training_1);
                         end

                     else %Si LBP NO aparece entre las caracteristicas
                            feature1_train = feature1_train(indices_baraje,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            feature2_train = feature2_train(indices_baraje,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2);

                     end

                switch criterio
                    case 1
                        precision = (correct/length(TEST_class_labels));
                    case 2
                        precision = (length(TEST_class_labels) - correct)/length(TEST_class_labels);
                    case 3
                        precision = f_pos;
                    case 4
                        precision = f_neg;
                    case 5
                        precision = (correct/length(TEST_class_labels));
                    case 6
                        precision = (correct/length(TEST_class_labels));
                    case 7
                        precision = t_pos;
                    case 8
                        precision = t_neg;
                end		              

            case 3
                        feature1 = features(1); feature2 = features(2); feature3 = features(3);
                        feature1_train = cargar_funcion(feature1); %Cargamos la característica calculada correspondiente
                        feature2_train = cargar_funcion(feature2); %Cargamos la característica calculada correspondiente                 
                        feature3_train = cargar_funcion(feature3); %Cargamos la característica calculada correspondiente
                
                        [row1, col1] = size(feature1_train);
                        [row2, col2] = size(feature2_train);
                        [row3, col3] = size(feature3_train);
                        matriz_long = [col1 col2 col3];
                        min_long = min(matriz_long); % Longitud mínima de las características

                      if find(features == 9)
                         if row1 > row2 && row1 > row3 %La feature 1 es LBP
                            indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                            feature1_train = feature1_train(indices_nuevos,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            feature2_train = feature2_train(indices_baraje,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            feature3_train = feature3_train(indices_baraje,:);
                            [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_3,valores_feature_training_3);
                         elseif row2 > row1 && row2 > row3 %La feature 2 es LBP
                            feature1_train = feature1_train(indices_baraje,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                            feature2_train = feature2_train(indices_nuevos,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            feature3_train = feature3_train(indices_baraje,:);
                            [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_2,valores_feature_training_2,valores_feature_test_1,valores_feature_training_1,valores_feature_test_3,valores_feature_training_3);
                         else % Entonces la feature 3 es LBP
                            feature1_train = feature1_train(indices_baraje,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            feature2_train = feature2_train(indices_baraje,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                            feature3_train = feature3_train(indices_nuevos,:);
                            [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_3,valores_feature_training_3,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2);
                         end
                      else %Si NO aparece LBP
                            feature1_train = feature1_train(indices_baraje,:);
                            [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                            feature2_train = feature2_train(indices_baraje,:);
                            [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                            feature3_train = feature3_train(indices_baraje,:);
                            [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                            [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_3,valores_feature_training_3);                    
                      end
                      
                switch criterio
                    case 1
                        precision = (correct/length(TEST_class_labels));
                    case 2
                        precision = (length(TEST_class_labels) - correct)/length(TEST_class_labels);
                    case 3
                        precision = f_pos;
                    case 4
                        precision = f_neg;
                    case 5
                        precision = (correct/length(TEST_class_labels));
                    case 6
                        precision = (correct/length(TEST_class_labels));
                    case 7
                        precision = t_pos;
                    case 8
                        precision = t_neg;
                end


            case 4
                    feature1 = features(1); feature2 = features(2); feature3 = features(3); feature4 = features(4);
                    
                    feature1_train = cargar_funcion(feature1); %Cargamos la característica calculada correspondiente
                    feature2_train = cargar_funcion(feature2); %Cargamos la característica calculada correspondiente                 
                    feature3_train = cargar_funcion(feature3); %Cargamos la característica calculada correspondiente
                    feature4_train = cargar_funcion(feature4); %Cargamos la característica calculada correspondiente
                        
                    [row1, col1] = size(feature1_train);
                    [row2, col2] = size(feature2_train);
                    [row3, col3] = size(feature3_train);
                    [row4, col4] = size(feature4_train);
                    matriz_long = [col1 col2 col3 col4];
                    matriz_rows = [row1 row2 row3 row4];
                    min_long = min(matriz_long); % Longitud mínima de las características

                if find(features == 9)
                    if max(matriz_rows)==row1 && max(matriz_rows) ~= row2 %La feature 1 es LBP
                        indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                        feature1_train = feature1_train(indices_nuevos,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        feature2_train = feature2_train(indices_baraje,:);
                        [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                        feature3_train = feature3_train(indices_baraje,:);
                        [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                        feature4_train = feature4_train(indices_baraje,:);
                        [valores_feature_training_4,valores_feature_test_4]= reparte(feature4_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_3,valores_feature_training_3,valores_feature_test_4,valores_feature_training_4);
                    elseif max(matriz_rows) == row2 && max(matriz_rows) ~= row1 %La feature 2 es LBP
                        feature1_train = feature1_train(indices_baraje,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                        feature2_train = feature2_train(indices_nuevos,:);
                        [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                        feature3_train = feature3_train(indices_baraje,:);
                        [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                        feature4_train = feature4_train(indices_baraje,:);
                        [valores_feature_training_4,valores_feature_test_4]= reparte(feature4_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_2,valores_feature_training_2,valores_feature_test_1,valores_feature_training_1,valores_feature_test_3,valores_feature_training_3,valores_feature_test_4,valores_feature_training_4);
                     elseif max(matriz_rows)==row3 && max(matriz_rows) ~= row1 %La feature 3 es LBP
                        feature1_train = feature1_train(indices_baraje,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        feature2_train = feature2_train(indices_baraje,:);
                        [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                        indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                        feature3_train = feature3_train(indices_nuevos,:);
                        [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                        feature4_train = feature4_train(indices_baraje,:);
                        [valores_feature_training_4,valores_feature_test_4]= reparte(feature4_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_3,valores_feature_training_3,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_4,valores_feature_training_4);
                      else %La feature 4 es LBP
                        feature1_train = feature1_train(indices_baraje,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        feature2_train = feature2_train(indices_baraje,:);
                        [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                        feature3_train = feature3_train(indices_baraje,:);
                        [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                        indices_nuevos = indices_lbp(indices_baraje,tam_ventana);
                        feature4_train = feature4_train(indices_nuevos,:);
                        [valores_feature_training_4,valores_feature_test_4]= reparte(feature4_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision_lbp(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_4,valores_feature_training_4,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_3,valores_feature_training_3); 
                    end
                      else %Si NO aparece LBP
                        feature1_train = feature1_train(indices_baraje,:);
                        [valores_feature_training_1,valores_feature_test_1]= reparte(feature1_train, npartes, parte_test);
                        feature2_train = feature2_train(indices_baraje,:);
                        [valores_feature_training_2,valores_feature_test_2]= reparte(feature2_train, npartes, parte_test);
                        feature3_train = feature3_train(indices_baraje,:);
                        [valores_feature_training_3,valores_feature_test_3]= reparte(feature3_train, npartes, parte_test);
                        feature4_train = feature4_train(indices_baraje,:);
                        [valores_feature_training_4,valores_feature_test_4]= reparte(feature4_train, npartes, parte_test);
                        [correct, f_pos, f_neg, t_pos, t_neg] = bucle_precision(TEST_class_labels,TRAIN_class_labels,min_long,tam_ventana,criterio,valores_feature_test_1,valores_feature_training_1,valores_feature_test_2,valores_feature_training_2,valores_feature_test_3,valores_feature_training_3,valores_feature_test_4,valores_feature_training_4);                    

                end
                
                switch criterio
                    case 1
                        precision = (correct/length(TEST_class_labels));
                    case 2
                        precision = (length(TEST_class_labels) - correct)/length(TEST_class_labels);
                    case 3
                        precision = f_pos;
                    case 4
                        precision = f_neg;
                    case 5
                        precision = (correct/length(TEST_class_labels));
                    case 6
                        precision = (correct/length(TEST_class_labels));
                    case 7
                        precision = t_pos;
                    case 8
                        precision = t_neg;
                end
            
            otherwise
                error('Ha introducido demasiados argumentos')
        end
    end
end