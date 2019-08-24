%% Funcion que devuelve la etiqueta predicha

% Inputs = etiquetas de training, matriz MLFS de test, minima long de las
% caracteristicas de la combinacion, criterio utilizado y las matrices de
% las caracteristicas de training utilizadas
% Output = La etiqueta de la instancia mas cercana

function etiqueta = dame_etiqueta_test(labels_tr,matriz_test,min_long,crit,feat1_tr,feat2_tr,feat3_tr,feat4_tr)

% Inhabilitamos los warnings
[~, LASTID] = lastwarn;
warning('OFF', LASTID);

% Inicializamos la etiqueta
etiqueta = 0;
    
    switch nargin %% switch en funcion del numero de caracteristicas
	
	case 5
        if crit == 5
            
            best_3 = [inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_3 = [0 0 0]; % Inicializamos el vector de etiquetas
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = feat1_tr(i,1:min_long);
                matriz_comparacion = cov(MLFS_comparacion');
                
                %% Distancia Riemannian
                distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_3)
                    if sum(best_3==max(best_3)) > 1
                        etiquetas_3(find(best_3==max(best_3),1)) = labels_tr(i);
                        best_3(find(best_3==max(best_3),1)) = distance_Riemannian;                         
                    else
                        etiquetas_3(best_3==max(best_3)) = labels_tr(i);
                        best_3(best_3==max(best_3)) = distance_Riemannian;                        
                    end
                end   
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_3 == 1) > 1
                etiqueta = 1;
            else
                etiqueta = -1;
            end
        elseif crit == 6
            
            best_5 = [inf inf inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_5 = [0 0 0 0 0]; % Inicializamos el vector de etiquetas
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = feat1_tr(i,1:min_long);
                matriz_comparacion = cov(MLFS_comparacion');
                
                %% Distancia Riemannian
                distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_5)
                    if sum(best_5==max(best_5)) > 1
                        etiquetas_5(find(best_5==max(best_5),1)) = labels_tr(i);
                        best_5(find(best_5==max(best_5),1)) = distance_Riemannian;                          
                    else
                        etiquetas_5(best_5==max(best_5)) = labels_tr(i);
                        best_5(best_5==max(best_5)) = distance_Riemannian;                         
                    end
                end   
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_5 == 1) > 2
                etiqueta = 1;
            else
                etiqueta = -1;
            end
            
        else
            
            best = inf;
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = feat1_tr(i,1:min_long);
                matriz_comparacion = cov(MLFS_comparacion');
                
                %% Distancia Riemannian
                distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < best
                    etiqueta = labels_tr(i);  
                    best = distance_Riemannian;
                end

            end
        end
        
    case 6
        if crit == 5
            
            best_3 = [inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_3 = [0 0 0]; % Inicializamos el vector de etiquetas
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
               %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
               
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_3)
                    if sum(best_3==max(best_3)) > 1
                        etiquetas_3(find(best_3==max(best_3),1)) = labels_tr(i);
                        best_3(find(best_3==max(best_3),1)) = distance_Riemannian;                          
                    else
                        etiquetas_3(best_3==max(best_3)) = labels_tr(i);
                        best_3(best_3==max(best_3)) = distance_Riemannian;                        
                    end
                end   
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_3 == 1) > 1
                etiqueta = 1;
            else
                etiqueta = -1;
            end
        elseif crit == 6
            best_5 = [inf inf inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_5 = [0 0 0 0 0]; % Inicializamos el vector de etiquetas
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                 %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_5)
                    if sum(best_5==max(best_5)) > 1
                        etiquetas_5(find(best_5==max(best_5),1)) = labels_tr(i);
                        best_5(find(best_5==max(best_5),1)) = distance_Riemannian;                         
                    else
                        etiquetas_5(best_5==max(best_5)) = labels_tr(i);
                        best_5(best_5==max(best_5)) = distance_Riemannian;                        
                    end
                end   
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_5 == 1) > 2
                etiqueta = 1;
            else
                etiqueta = -1;
            end
        else
            best = inf;
            
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                 %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < best
                    etiqueta = labels_tr(i);  
                    best = distance_Riemannian;
                end           
            end
        end
        		
	case 7
        if crit == 5
            best_3 = [inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_3 = [0 0 0]; % Inicializamos el vector de etiquetas
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                 %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_3)
                    if sum(best_3==max(best_3)) > 1
                        etiquetas_3(find(best_3==max(best_3),1)) = labels_tr(i);
                        best_3(find(best_3==max(best_3),1)) = distance_Riemannian; 
                    else
                        etiquetas_3(best_3==max(best_3)) = labels_tr(i);
                        best_3(best_3==max(best_3)) = distance_Riemannian;                        
                    end
                end 
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_3 == 1) > 1
                etiqueta = 1;
            else
                etiqueta = -1;
            end
        elseif crit == 6
            best_5 = [inf inf inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_5 = [0 0 0 0 0]; % Inicializamos el vector de etiquetas
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_5)
                    if sum(best_5==max(best_5)) > 1
                        etiquetas_5(find(best_5==max(best_5),1)) = labels_tr(i);
                        best_5(find(best_5==max(best_5),1)) = distance_Riemannian;                        
                    else
                        etiquetas_5(best_5==max(best_5)) = labels_tr(i);
                        best_5(best_5==max(best_5)) = distance_Riemannian;                        
                    end
                end 
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_5 == 1) > 2
                etiqueta = 1;
            else
                etiqueta = -1;
            end            
        else
            best = inf;
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan 
                end
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < best
                    etiqueta = labels_tr(i);  
                    best = distance_Riemannian;
                 end
            end            
        end
	
	case 8
        if crit == 5
            best_3 = [inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_3 = [0 0 0]; % Inicializamos el vector de etiquetas
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long);feat4_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan 
                end 
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_3)
                    if sum(best_3==max(best_3)) > 1
                        etiquetas_3(find(best_3==max(best_3),1)) = labels_tr(i);
                        best_3(find(best_3==max(best_3),1)) = distance_Riemannian;                          
                    else
                        etiquetas_3(best_3==max(best_3)) = labels_tr(i);
                        best_3(best_3==max(best_3)) = distance_Riemannian;                        
                    end
                end 
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_3 == 1) > 1
                etiqueta = 1;
            else
                etiqueta = -1;
            end           
        elseif crit == 6
            best_5 = [inf inf inf inf inf]; % Inicializamos el vector de distancias
            etiquetas_5 = [0 0 0 0 0]; % Inicializamos el vector de etiquetas
            
            for i = 1 : length(labels_tr)  % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long);feat4_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < max(best_5)
                    if sum(best_5==max(best_5)) > 1
                        etiquetas_5(find(best_5==max(best_5),1)) = labels_tr(i);
                        best_5(find(best_5==max(best_5),1)) = distance_Riemannian;                         
                    else
                        etiquetas_5(best_5==max(best_5)) = labels_tr(i);
                        best_5(best_5==max(best_5)) = distance_Riemannian;                        
                    end
                end 
            end
            
            %% Mecanismo de seleccion de etiqueta predicha
            if sum(etiquetas_5 == 1) > 2
                etiqueta = 1;
            else
                etiqueta = -1;
            end                
        else
            best = inf;
            for i = 1 : length(labels_tr) % Bucle que recorre todas las instancias de las caracteristicas
                
                %% Creamos la matriz MLFS de training
                MLFS_comparacion = [feat1_tr(i,1:min_long);feat2_tr(i,1:min_long);feat3_tr(i,1:min_long);feat4_tr(i,1:min_long)];
                matriz_comparacion = cov(MLFS_comparacion');
                InforNaN = sum(isnan(matriz_test\matriz_comparacion)) + sum(isinf(matriz_test\matriz_comparacion));
                
                if InforNaN==0
                    %% Distancia Riemannian
                    distance_Riemannian = sqrt(sum(log(eig(matriz_test\matriz_comparacion)).^2));
                else
                    distance_Riemannian = 100; % Ponemos este valor para evitar Nan
                end
                
                %% Almacenamos las mejores distancias y sus etiquetas
                if distance_Riemannian < best
                    etiqueta = labels_tr(i);  
                    best = distance_Riemannian;
                end
            end            
        end
        
        otherwise
            error('Ha introducido demasiados argumentos')
    end
end