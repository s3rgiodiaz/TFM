%% Funcion principal que genera los ficheros con los resultados de cada ejecucion del algoritmo
% con las caracteristicas y dataset de entrenamiento

%% Realizamos una Validacion Cruzada con valores de (2,3,5,10 y LOO)
% Bucle para las distintas validaciones

hora_inicio = datestr(now); %Fecha y hora de inicio
%% Cargamos primero las instancias de Train del dataset de Lighting 2
TRAIN = load('..\Lighting2\Lighting2_TRAIN');

%% Definicion de variables estaticas
validacion_cruzada_valores = [2 3 5 10 size(TRAIN,1)];
n_criterios = 1:6;
features_id = 1:37;

% Quitamos las caracteristicas 6, 7 y 29 ya que no las utilizamos
[fil_to_del, col_to_del] = find(features_id==6 | features_id==7 | features_id==29);
features_id (col_to_del) = [];

%% Bucle para los distintos grupos de caracteristicas (de 1 a 4)
for n_features = 1 : 4
    
    n_caracteristicas = n_features;
    n_combinaciones = nchoosek(features_id,n_caracteristicas);
    
    
    for v_cruz = 1:length(validacion_cruzada_valores)
        
        NT = validacion_cruzada_valores(v_cruz);
        
        for ejecuciones = 1:10
            
            %% Generacion de vectores de training/validacion/test
            % Generamos los bloques de training y de test de forma aleatoria
            indices = zeros (1,size(TRAIN,1));
            rng('shuffle');
            cont = 1;
            while cont < round(rand*10) + 2
                indices = randperm(size(TRAIN,1)); %Esto lo hacemos round(rand*10) + 2 veces
                cont = cont + 1;
            end
            
            %% Con el resultado del baraje barajamos las instancias y creamos los bloques
            instancias = TRAIN(indices,:);
            
            
            
            matriz_completa = zeros(size(n_combinaciones,1)*NT,size(n_combinaciones,2)+63);
            
            
            %% Bucle para los distintos criterios
            % #1 KNN = 1 #2 Nº Errores #3 Nº Falsos Positivos #4 Nº Falsos Negativos
            % #5 KNN = 3 #6 KNN = 5
            for n_criterio = 1 : length(n_criterios)
                best_comb = Inf;
                
                for j = 1:NT
                    [training,test]= reparte(instancias, NT, j);
                    
                    
                    for i = 1:size(n_combinaciones,1) % Informe de progreso
                        switch n_caracteristicas
                            case 1
                                msg = sprintf('Combinacion %d de la ejecucion %d del criterio %d para un valor de validacion cruzada de %d y ejecucion general %d',n_combinaciones(i,:),j,n_criterio,NT,ejecuciones);
                                disp(msg);
                            case 2
                                msg = sprintf('Combinacion %d %d de la ejecucion %d del criterio %d para un valor de validacion cruzada de %d y ejecucion general %d',n_combinaciones(i,:),j,n_criterio,NT,ejecuciones);
                                disp(msg);
                            case 3
                                msg = sprintf('Combinacion %d %d %d de la ejecucion %d del criterio %d para un valor de validacion cruzada de %d y ejecucion general %d',n_combinaciones(i,:),j,n_criterio,NT,ejecuciones);
                                disp(msg);
                            case 4
                                msg = sprintf('Combinacion %d %d %d %d de la ejecucion %d del criterio %d para un valor de validacion cruzada de %d y ejecucion general %d',n_combinaciones(i,:),j,n_criterio,NT,ejecuciones);
                                disp(msg);
                        end
                        
                        [precision_criterio_elegido] = calcula_precision(training,test,n_criterio,indices,NT,j,n_combinaciones(i,:));
                        
                        %% Rellenamos la matriz con la informacion de la ejecucion
                        matriz_completa ((j-1)*size(n_combinaciones,1)+i,1:size(n_combinaciones(i,:),2)) = n_combinaciones(i,:);
                        matriz_completa ((j-1)*size(n_combinaciones,1)+i,size(n_combinaciones(i,:),2)+1) = n_criterio;
                        matriz_completa ((j-1)*size(n_combinaciones,1)+i,size(n_combinaciones(i,:),2)+2) = j;
                        matriz_completa ((j-1)*size(n_combinaciones,1)+i,size(n_combinaciones(i,:),2)+3) = precision_criterio_elegido;
                        matriz_completa ((j-1)*size(n_combinaciones,1)+i,size(n_combinaciones(i,:),2)+4:end) = indices;
                    end
                    
                end
                timestamp = datestr(now); %Fecha y hora de finalizacion
                timestamp(timestamp==':')='-'; %Eliminamos los :
                csvwrite(strcat('Matriz_completa_',int2str(NT),'_nfeat_',int2str(n_caracteristicas),'_crit_',int2str(n_criterio),'_',timestamp,'.csv'),matriz_completa); %Guardamos un csv con la informacoin de la ejecucion
                hora_final = datestr(now);
                msg_final = sprintf('Hora de inicio: %s \n Hora de fin: %s',hora_inicio,hora_final); % Tiempos de la ejecucion
                disp(msg_final);
            end
        end
    end
end
