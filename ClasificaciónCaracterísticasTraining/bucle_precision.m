%% Funcion bucle_precision. Parametros -> etiquetas de test, etiquetas de train, longitud minima de las características, tamaño de la ventana y valores de test y train de las características
%% Devuelve -> Numero de instancias correctas, numero de falsos positivos y numero de falsos negativos

function [correctas, falso_pos, falso_neg, true_pos,true_neg] = bucle_precision(labels_test,labels_tr,min_long,ventana,criterion,valores_test_1,valores_train_1,valores_test_2,valores_train_2,valores_test_3,valores_train_3,valores_test_4,valores_train_4)

    correctas = 0;
    falso_pos = 0;
    falso_neg = 0;
    true_pos = 0;
    true_neg = 0;
	
	switch nargin

		case 7
            for i = 1 : length(labels_test) % Bucle sobre cada instancia de test
				this_objects_actual_class = labels_test(i); %Clase de esta instancia
				%% Montamos la matriz MLFS
				MLFS = valores_test_1(i,:);
				matriz_cov_MLFS = cov(MLFS');
				predicted_class = algoritmo_Clasificacion(labels_tr,matriz_cov_MLFS,min_long,ventana,criterion,valores_train_1);
				
                    if predicted_class == this_objects_actual_class 
						correctas = correctas + 1;
                        if predicted_class == 1
                            true_pos =  true_pos + 1;
                        else
                            true_neg = true_neg + 1;
                        end
                    else
                        if predicted_class == 1
                            falso_pos = falso_pos + 1;
                        else
                             falso_neg = falso_neg + 1;
                        end
                    end
            end
		
		case 9
            for i = 1 : length(labels_test) % Bucle sobre cada instancia de test
                this_objects_actual_class = labels_test(i); %Clase de esta instancia
                %% Montamos la matriz MLFS
                MLFS = [valores_test_1(i,1:min_long);valores_test_2(i,1:min_long)];
                matriz_cov_MLFS = cov(MLFS');
                predicted_class = algoritmo_Clasificacion(labels_tr,matriz_cov_MLFS,min_long,ventana,criterion,valores_train_1,valores_train_2);
                    if predicted_class == this_objects_actual_class 
						correctas = correctas + 1;
                        if predicted_class == 1
                            true_pos =  true_pos + 1;
                        else
                            true_neg = true_neg + 1;
                        end
                    else
                        if predicted_class == 1
                            falso_pos = falso_pos + 1;
                        else
                             falso_neg = falso_neg + 1;
                        end
                    end
            end
			 
		case 11
            for i = 1 : length(labels_test) % Bucle sobre cada instancia de test
                this_objects_actual_class = labels_test(i); %Clase de esta instancia
                %% Montamos la matriz MLFS
                MLFS = [valores_test_1(i,1:min_long);valores_test_2(i,1:min_long);valores_test_3(i,1:min_long)];
                matriz_cov_MLFS = cov(MLFS');
                predicted_class = algoritmo_Clasificacion(labels_tr,matriz_cov_MLFS,min_long,ventana,criterion,valores_train_1,valores_train_2,valores_train_3);
                    if predicted_class == this_objects_actual_class 
						correctas = correctas + 1;
                        if predicted_class == 1
                            true_pos =  true_pos + 1;
                        else
                            true_neg = true_neg + 1;
                        end
                    else
                        if predicted_class == 1
                            falso_pos = falso_pos + 1;
                        else
                             falso_neg = falso_neg + 1;
                        end
                    end
            end
		
		case 13
            for i = 1 : length(labels_test) % Bucle sobre cada instancia de test
                this_objects_actual_class = labels_test(i); %Clase de esta instancia
                %% Montamos la matriz MLFS
                MLFS = [valores_test_1(i,1:min_long);valores_test_2(i,1:min_long);valores_test_3(i,1:min_long);valores_test_4(i,1:min_long)];
                matriz_cov_MLFS = cov(MLFS');
                predicted_class = algoritmo_Clasificacion(labels_tr,matriz_cov_MLFS,min_long,ventana,criterion,valores_train_1,valores_train_2,valores_train_3,valores_train_4);
                    if predicted_class == this_objects_actual_class 
						correctas = correctas + 1;
                        if predicted_class == 1
                            true_pos =  true_pos + 1;
                        else
                            true_neg = true_neg + 1;
                        end
                    else
                        if predicted_class == 1
                            falso_pos = falso_pos + 1;
                        else
                             falso_neg = falso_neg + 1;
                        end
                    end
            end		
			 
		otherwise
			error('Ha introducido un numero incorrecto de argumentos')			 
end

