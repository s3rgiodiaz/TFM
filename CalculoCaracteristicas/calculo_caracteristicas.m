%% Fichero que calcula las caracteristicas de los datasets

%% Definicion de ficheros a abrir
TRAIN = load('..\Lighting2\Lighting2_TRAIN');
TEST = load('..\Lighting2\Lighting2_TEST');

tam_ventana = 17; % Longitud de la ventana

TRAIN_class_labels = TRAIN(:,1); % Extraemos las etiquetas de las instancias
TRAIN(:,1) = []; % Eliminamos las etiquetas del conjunto de datos

TEST_class_labels = TEST(:,1); % Extraemos las etiquetas de las instancias
TEST(:,1) = []; % Eliminamos las etiquetas del conjunto de datos

primera_instancia_train = TRAIN(1,:); % Cogemos la primera instancia de train
primera_instancia_test = TEST(1,:); % Cogemos la primera instancia de test


%% Inicializacion de matrices
identity_map_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
identity_map_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

frecuencia_inst_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
frecuencia_inst_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

primera_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train)-1);
primera_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test)-1);

segunda_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train)-2);
segunda_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test)-2);

desviacion_estandar_train = zeros (length(TRAIN_class_labels),length(primera_instancia_train));
desviacion_estandar_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

media_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
media_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

LBP_train = zeros (length(TRAIN_class_labels)*(tam_ventana*2-2),length(primera_instancia_train));
LBP_test = zeros (length(TEST_class_labels)*(tam_ventana*2-2),length(primera_instancia_test));

SWD_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
SWA_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
SWD_test = zeros(length(TEST_class_labels),length(primera_instancia_test));
SWA_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

mediamovil_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
mediamovil_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

suma_acum_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
suma_acum_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

varianza_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
varianza_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

primera_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
primera_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

segunda_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
segunda_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

LBP_paper_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
LBP_paper_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

corr_primera_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
corr_primera_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

corr_segunda_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
corr_segunda_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

corr_primera_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
corr_primera_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

corr_segunda_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
corr_segunda_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

autocorr_primera_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
autocorr_primera_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

autocorr_segunda_derivada_diff_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
autocorr_segunda_derivada_diff_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

maximos_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
maximos_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

local_fluc_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
local_fluc_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

q_RMS_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
q_RMS_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

DEP_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
DEP_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

tf_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
tf_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

moda_train =  zeros(length(TRAIN_class_labels),length(primera_instancia_train));
moda_test =  zeros(length(TEST_class_labels),length(primera_instancia_test));

energia_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
energia_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

potencia_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
potencia_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

autocorr_primera_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
autocorr_primera_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

autocorr_segunda_derivada_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
autocorr_segunda_derivada_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

anchura_pico_max_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
anchura_pico_max_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

pos_pico_max_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
pos_pico_max_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

max_locales_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
max_locales_test = zeros(length(TEST_class_labels),length(primera_instancia_test));

min_locales_train = zeros(length(TRAIN_class_labels),length(primera_instancia_train));
min_locales_test = zeros(length(TEST_class_labels),length(primera_instancia_test));


%% Datos necesarios para el calculo de la SWT
N_train = floor(log2(length(primera_instancia_train)));
base2_train = floor(log2(N_train));
longitudSignal_train = floor(length(primera_instancia_train)/(2^base2_train));

N_test = floor(log2(length(primera_instancia_test)));
base2_test = floor(log2(N_test));
longitudSignal_test = floor(length(primera_instancia_test)/(2^base2_test));

%% Calculo caracteristicas de train
for i = 1 : length(TRAIN_class_labels) % Bucle para recorrer todo el dataset
    classify_this_object = TRAIN(i,:); % Cogemos cada instancia
    
    %% Identity map
    identity_map_train(i,:) = classify_this_object;
    
    %% Freq Inst
    z = hilbert(classify_this_object);
    frecuencia_inst_train(i,1:end-1) = 1/(2*pi)*diff(unwrap(angle(z)));
    frecuencia_inst_train(i,end) = frecuencia_inst_train(i,end-1);
    
    %% 1 & 2 order derivative
    primera_derivada_train(i,:) = classify_this_object(2:end);
    
    segunda_derivada_train(i,:) = classify_this_object(3:end);
    
    %% SWT
    [swa,swd] = swt(classify_this_object(1:longitudSignal_train*(2^base2_train)),base2_train,'coif4');
    SWA_train(i,1:longitudSignal_train*(2^base2_train)) = swa(base2_train,:);
    SWA_train(i,longitudSignal_train*(2^base2_train)+1:end) = SWA_train(i,longitudSignal_train*(2^base2_train));
    SWD_train(i,1:longitudSignal_train*(2^base2_train)) = swd(base2_train,:);
    SWD_train(i,longitudSignal_train*(2^base2_train)+1:end) = SWD_train(i,longitudSignal_train*(2^base2_train));
    
    %% Media Movil
    mediamovil_train(i,:) = movingmean(classify_this_object',tam_ventana,1,1)';
    
    %% Suma Acumulada
    suma_acum_train(i,:) = cumsum(classify_this_object);
    
    %% Primera derivada Diff
    primera_derivada_diff_train(i,1:end-1) = diff(classify_this_object);
    primera_derivada_diff_train(i,end) = 0;
    
    %% Segunda derivada Diff
    segunda_derivada_diff_train(i,1:end-2) = diff(classify_this_object,2);
    segunda_derivada_diff_train(i,end-1:end) = 0;
    
    %% Correlacion primera derivada
    aux = xcorr(classify_this_object(2:end),classify_this_object);
    corr_primera_derivada_train(i,:) = aux(length(classify_this_object(2:end)):end-1);
    
    %% Correlacion segunda derivada
    aux1 = xcorr(classify_this_object(3:end),classify_this_object);
    corr_segunda_derivada_train(i,:) = aux1(length(classify_this_object(3:end))+1:end-1);
    
    %% Correlacion primera derivada diff
    aux2 = xcorr(diff(classify_this_object),classify_this_object);
    corr_primera_derivada_diff_train(i,:) = aux2(length(diff(classify_this_object)):end-1);
    
    %% Correlacion segunda derivada diff
    aux3 = xcorr(diff(classify_this_object,2),classify_this_object);
    corr_segunda_derivada_diff_train(i,:) = aux3(length(diff(classify_this_object,2)):end-2);
    
    %% Autocorrelacion primera derivada
    aux4 = xcorr(classify_this_object(2:end),'coeff');
    autocorr_primera_derivada_train(i,:) = aux4(end-length(classify_this_object(2:end)):end);
    
    %% Autocorrelacion segunda derivada
    aux5 = xcorr(classify_this_object(3:end),classify_this_object(3:end));
    autocorr_segunda_derivada_train(i,:) = aux5(end-length(classify_this_object(3:end))-1:end);
    
    %% Autocorrelacion primera derivada diff
    aux6 = xcorr(diff(classify_this_object),'coeff');
    autocorr_primera_derivada_diff_train(i,1:end-1) = aux6(end-length(diff(classify_this_object))+1:end);
    autocorr_primera_derivada_diff_train(i,end) = aux6(1);
    
    %% Autocorrelacion segunda derivada diff
    aux7 = xcorr(diff(classify_this_object,2),'coeff');
    autocorr_segunda_derivada_diff_train(i,1:end-1) = aux7(end-length(diff(classify_this_object,2)):end);
    autocorr_segunda_derivada_diff_train(i,end) = aux7(1);
    
    %% Pico maximo ,anchura y posicion
    [peak_value, peak_location, peak_width] = findpeaks(classify_this_object,'MinPeakHeight',3,'NPeaks',1);
    maximos_train (i,:) = sqrt(peak_value/length(classify_this_object));
    anchura_pico_max_train(i,:) = sqrt(peak_width/length(classify_this_object));
    pos_pico_max_train(i,:) = sqrt(peak_location/length(classify_this_object));    
    
    %% Local Fluctuation
    X = cumsum(classify_this_object);
    scale = 7;
    m = 1;
    segments = floor(length(X)/scale);
    
    for v = 1 : segments,
        Idx_start = ((v-1)*scale)+1;
        Idx_stop = v * scale;
        Index{v,1} = Idx_start:Idx_stop;
        X_Idx = X(Index{v,1});
        C = polyfit(Index{v,1},X(Index{v,1}),m);
        fit{v,1} = polyval(C,Index{v,1});
        RMS{1}(v) = sqrt(mean((X_Idx-fit{v,1}).^2));
    end
    
    vector_producto = kron(RMS{1,1}, ones(scale,1));
    vector_final = reshape(vector_producto,1,size(vector_producto,1)*size(vector_producto,2));
    
    local_fluc_train(i,:) = vector_final;

    %% qRMS
    q = 1;
    for v1 = 1 : segments,
        Index1 = ((((v1-1)*scale)+1):(v1*scale));
        C1 = polyfit(Index1,X(Index1),m);
        fit1 = polyval(C1,Index1);
        RMS1(Index1)=sqrt(mean((X(Index1)-fit1).^2));
    end
    
    for nq = 1:length(q),
        qRMS_vector{i}{nq}=RMS1.^q(nq);
    end
    
    q_RMS_train(i,:) = qRMS_vector{1,i}{1,1};
    
    %% DEP
    modulo_tf = fft(classify_this_object)/length(classify_this_object);
    DEP_train(i,:) = modulo_tf.*conj(modulo_tf);
    
    %% TF
    L = length(classify_this_object);
    S = fft(classify_this_object);
    Y = abs(S/L);
    tf_train(i,1:fix(L/2))=  Y(fix(L/2)+2:end);
    tf_train(i,fix(L/2)+1)=  Y(1);
    tf_train(i,fix(L/2)+2:end)= fliplr(tf_train(i,1:fix(L/2)));
    
    %% Caracteristicas ventanales
    for j = 1 : length(classify_this_object)
        
        if j + tam_ventana < length(classify_this_object)
            %% Desviacion estandar
            desviacion_estandar_train(i,j) = std(classify_this_object(j:j+(tam_ventana-1)));
            
            %% Media
            media_train(i,j) = mean(classify_this_object(j:j+(tam_ventana-1)));
            
            %% Varianza
            varianza_train(i,j) = var(classify_this_object(j:j+tam_ventana-1));
            
            %% Moda
            moda_train(i,j) = mode(classify_this_object(j:j+tam_ventana-1));
            
            %% Energia
            energia_train(i,j) = sum(classify_this_object(j:j+tam_ventana-1).^2);
            
            %% Potencia
            potencia_train(i,j)=sum(classify_this_object(j:j+tam_ventana-1).^2)/tam_ventana;
            
            %% Maximos y Minimos Ventanales
            max_locales_train(i,j) = max(classify_this_object(j:j+tam_ventana-1));
            min_locales_train(i,j) = min(classify_this_object(j:j+tam_ventana-1));
            
        else
            %% Desviacion estandar
            desviacion_estandar_train(i,j) = std(classify_this_object(j:end));
            
            %% Media
            media_train(i,j) = mean(classify_this_object(j:end));
            
            %% Varianza
            varianza_train(i,j) = var(classify_this_object(j:end));
            
            %% LBP Paper
            if j + tam_ventana <= length(classify_this_object)
                LBP_paper_train(i,j) = lbp_paper(classify_this_object(j:j+tam_ventana-1));
            else
                LBP_paper_train(i,j) = lbp_paper(classify_this_object(j:end));
            end
            
            %% Moda
            moda_train(i,j) = mode(classify_this_object(j:end));
            
            %% Energia
            energia_train(i,j) = sum(classify_this_object(j:end).^2);
            
            %% Potencia
            potencia_train(i,j)=sum(classify_this_object(j:end).^2)/length(classify_this_object(j:end));
            
            %% Maximos y Minimos Ventanales
            max_locales_train(i,j) = max(classify_this_object(j:end));
            min_locales_train(i,j) = min(classify_this_object(j:end));
            
        end
        
    end
    
    for j = 1 : length(classify_this_object) - tam_ventana
        %% LBP
        if j < mod(length(classify_this_object),tam_ventana)
            valores = classify_this_object(1:mod(length(classify_this_object),tam_ventana)+j-1);
            relleno = zeros(1,tam_ventana-mod(length(classify_this_object),tam_ventana)-j+1);
            vector = [relleno valores];
            LBP_train((i-1)*(tam_ventana*2-2)+1:(tam_ventana*2-2)*(i-1)+(tam_ventana*2-2),j)= lbp(vector)';
        else
            LBP_train((i-1)*(tam_ventana*2-2)+1:(tam_ventana*2-2)*(i-1)+(tam_ventana*2-2),j) = lbp(classify_this_object(j-mod(length(classify_this_object),tam_ventana)+1:j-mod(length(classify_this_object),tam_ventana)+1+tam_ventana-1))';
        end
    end    
end

%% Creacion de ficheros con las caracteristicas de train
csvwrite('Feature_1_Lighting2_Train.dat',identity_map_train);
csvwrite('Feature_2_Lighting2_Train.dat',frecuencia_inst_train);
csvwrite('Feature_3_Lighting2_Train.dat',primera_derivada_train);
csvwrite('Feature_4_Lighting2_Train.dat',segunda_derivada_train);
csvwrite('Feature_5_Lighting2_Train.dat',desviacion_estandar_train);
csvwrite('Feature_6_Lighting2_Train.dat',media_train);
csvwrite('Feature_8_Lighting2_Train.dat',LBP_train);
csvwrite('Feature_9_Lighting2_Train.dat',SWD_train);
csvwrite('Feature_10_Lighting2_Train.dat',mediamovil_train);
csvwrite('Feature_11_Lighting2_Train.dat',suma_acum_train);
csvwrite('Feature_12_Lighting2_Train.dat',varianza_train);
csvwrite('Feature_13_Lighting2_Train.dat',primera_derivada_diff_train);
csvwrite('Feature_14_Lighting2_Train.dat',segunda_derivada_diff_train);
csvwrite('Feature_15_Lighting2_Train.dat',LBP_paper_train);
csvwrite('Feature_16_Lighting2_Train.dat',corr_primera_derivada_train);
csvwrite('Feature_17_Lighting2_Train.dat',corr_segunda_derivada_train);
csvwrite('Feature_18_Lighting2_Train.dat',corr_primera_derivada_diff_train);
csvwrite('Feature_19_Lighting2_Train.dat',corr_segunda_derivada_diff_train);
csvwrite('Feature_20_Lighting2_Train.dat',autocorr_primera_derivada_diff_train);
csvwrite('Feature_21_Lighting2_Train.dat',autocorr_segunda_derivada_diff_train);
csvwrite('Feature_22_Lighting2_Train.dat',maximos_train);
csvwrite('Feature_23_Lighting2_Train.dat',local_fluc_train);
csvwrite('Feature_24_Lighting2_Train.dat',q_RMS_train);
csvwrite('Feature_25_Lighting2_Train.dat',DEP_train);
csvwrite('Feature_26_Lighting2_Train.dat',tf_train);
csvwrite('Feature_27_Lighting2_Train.dat',moda_train);
csvwrite('Feature_28_Lighting2_Train.dat',energia_train);
csvwrite('Feature_30_Lighting2_Train.dat',potencia_train);
csvwrite('Feature_31_Lighting2_Train.dat',autocorr_primera_derivada_train);
csvwrite('Feature_32_Lighting2_Train.dat',autocorr_segunda_derivada_train);
csvwrite('Feature_33_Lighting2_Train.dat',anchura_pico_max_train);
csvwrite('Feature_34_Lighting2_Train.dat',pos_pico_max_train);
csvwrite('Feature_35_Lighting2_Train.dat',anchura_pico_max_train);
csvwrite('Feature_36_Lighting2_Train.dat',max_locales_train);
csvwrite('Feature_37_Lighting2_Train.dat',min_locales_train);

%% Calculo caracteristicas de test
for i = 1 : length(TEST_class_labels) % Bucle para recorrer todo el dataset
    classify_this_object = TEST(i,:); % Cogemos cada instancia
    
    %% Identity map
    identity_map_test(i,:) = classify_this_object;
    
    %% Freq Inst
    z = hilbert(classify_this_object);
    frecuencia_inst_test(i,1:end-1) = 1/(2*pi)*diff(unwrap(angle(z)));
    frecuencia_inst_test(i,end) = frecuencia_inst_test(i,end-1);
    
    %% 1 & 2 order derivative
    primera_derivada_test(i,:) = classify_this_object(2:end);
    
    segunda_derivada_test(i,:) = classify_this_object(3:end);
    
    %% SWT
    [swa,swd] = swt(classify_this_object(1:longitudSignal_test*(2^base2_test)),base2_test,'coif4');
    SWA_test(i,1:longitudSignal_test*(2^base2_test)) = swa(base2_test,:);
    SWA_test(i,longitudSignal_test*(2^base2_test)+1:end) = SWA_test(i,longitudSignal_test*(2^base2_test));
    SWD_test(i,1:longitudSignal_test*(2^base2_test)) = swd(base2_test,:);
    SWD_test(i,longitudSignal_test*(2^base2_test)+1:end) = SWD_test(i,longitudSignal_test*(2^base2_test));
    
    %% Media Movil
    mediamovil_test(i,:) = movingmean(classify_this_object',tam_ventana,1,1)';
    
    %% Suma Acumulada
    suma_acum_test(i,:) = cumsum(classify_this_object);
    
    %% Primera derivada Diff
    primera_derivada_diff_test(i,1:end-1) = diff(classify_this_object);
    primera_derivada_diff_test(i,end) = 0;
    
    %% Segunda derivada Diff
    segunda_derivada_diff_test(i,1:end-2) = diff(classify_this_object,2);
    segunda_derivada_diff_test(i,end-1:end) = 0;
    
    %% Correlacion primera derivada
    aux = xcorr(classify_this_object(2:end),classify_this_object);
    corr_primera_derivada_test(i,:) = aux(length(classify_this_object(2:end)):end-1);
    
    %% Correlacion segunda derivada
    aux1 = xcorr(classify_this_object(3:end),classify_this_object);
    corr_segunda_derivada_test(i,:) = aux1(length(classify_this_object(3:end))+1);
    
    %% Correlacion primera derivada diff
    aux2 = xcorr(diff(classify_this_object),classify_this_object);
    corr_primera_derivada_diff_test(i,:) = aux2(length(diff(classify_this_object)):end-1);
    
    %% Correlacion segunda derivada diff
    aux3 = xcorr(diff(classify_this_object,2),classify_this_object);
    corr_segunda_derivada_diff_test(i,:) = aux3(length(diff(classify_this_object,2)):end-2);
    
    %% Autocorrelacion primera derivada
    aux4 = xcorr(classify_this_object(2:end),'coeff');
    autocorr_primera_derivada_test(i,:) = aux4(end-length(classify_this_object(2:end)):end);
    
    %% Autocorrelacion segunda derivada
    aux5 = xcorr(classify_this_object(3:end),classify_this_object(3:end));
    autocorr_segunda_derivada_test(i,:) = aux5(end-length(classify_this_object(3:end))-1:end);
    
    %% Autocorrelacion primera derivada diff
    aux6 = xcorr(diff(classify_this_object),'coeff');
    autocorr_primera_derivada_diff_test(i,1:end-1) = aux6(end-length(diff(classify_this_object))+1:end);
    autocorr_primera_derivada_diff_test(i,end) = aux6(1);
    
    %% Autocorrelacion segunda derivada diff
    aux7 = xcorr(diff(classify_this_object,2),'coeff');
    autocorr_segunda_derivada_diff_test(i,1:end-1) = aux7(end-length(diff(classify_this_object,2)):end);
    autocorr_segunda_derivada_diff_test(i,end) = aux7(1);
    
    %% Pico maximo ,anchura y posicion
    [peak_value, peak_location, peak_width] = findpeaks(classify_this_object,'MinPeakHeight',3,'NPeaks',1);
    maximos_test (i,:) = sqrt(peak_value/length(classify_this_object));
    anchura_pico_max_test(i,:) = sqrt(peak_width/length(classify_this_object));
    pos_pico_max_test(i,:) = sqrt(peak_location/length(classify_this_object));    
    
    %% Local Fluctuation
    X = cumsum(classify_this_object);
    scale = 7;
    m = 1;
    segments = floor(length(X)/scale);
    
    for v = 1 : segments,
        Idx_start = ((v-1)*scale)+1;
        Idx_stop = v * scale;
        Index{v,1} = Idx_start:Idx_stop;
        X_Idx = X(Index{v,1});
        C = polyfit(Index{v,1},X(Index{v,1}),m);
        fit{v,1} = polyval(C,Index{v,1});
        RMS{1}(v) = sqrt(mean((X_Idx-fit{v,1}).^2));
    end
    
    vector_producto = kron(RMS{1,1}, ones(scale,1));
    vector_final = reshape(vector_producto,1,size(vector_producto,1)*size(vector_producto,2));
    
    local_fluc_test(i,:) = vector_final;
    
    %% qRMS
    q = 1;
    for v1 = 1 : segments,
        Index1 = ((((v1-1)*scale)+1):(v1*scale));
        C1 = polyfit(Index1,X(Index1),m);
        fit1 = polyval(C1,Index1);
        RMS1(Index1)=sqrt(mean((X(Index1)-fit1).^2));
    end
    
    for nq = 1:length(q),
        qRMS_vector{i}{nq}=RMS1.^q(nq);
    end
    
    q_RMS_test(i,:) = qRMS_vector{1,i}{1,1};
    
    %% DEP
    modulo_tf = fft(classify_this_object)/length(classify_this_object);
    DEP_test(i,:) = modulo_tf.*conj(modulo_tf);
    
    %% TF
    L = length(classify_this_object);
    S = fft(classify_this_object);
    Y = abs(S/length(classify_this_object));
    tf_test(i,1:fix(L/2))=  Y(fix(L/2)+2:end);
    tf_test(i,fix(L/2)+1)=  Y(1);
    tf_test(i,fix(L/2)+2:end)= fliplr(tf_test(i,1:fix(L/2)));
    
    %% Caracteristicas ventanales
    for j = 1 : length(classify_this_object)
        
        if j + tam_ventana < length(classify_this_object)
            %% Desviacion estandar
            desviacion_estandar_test(i,j) = std(classify_this_object(j:j+(tam_ventana-1)));
            
            %% Media
            media_test(i,j) = mean(classify_this_object(j:j+(tam_ventana-1)));
            
            %% Varianza
            varianza_test(i,j) = var(classify_this_object(j:j+tam_ventana-1));
            
            %% Moda
            moda_test(i,j) = mode(classify_this_object(j:j+tam_ventana-1));
            
            %% Energia
            energia_test(i,j) = sum(classify_this_object(j:j+tam_ventana-1).^2);
            
            %% Potencia
            potencia_test(i,j)=sum(classify_this_object(j:j+tam_ventana-1).^2)/tam_ventana;
            
            %% Maximos y Minimos Ventanales
            max_locales_test(i,j) = max(classify_this_object(j:j+tam_ventana-1));
            min_locales_test(i,j) = min(classify_this_object(j:j+tam_ventana-1));
            
        else
            %% Desviacion estandar
            desviacion_estandar_test(i,j) = std(classify_this_object(j:end));
            
            %% Media
            media_test(i,j) = mean(classify_this_object(j:end));
            
            %% Varianza
            varianza_test(i,j) = var(classify_this_object(j:end));
            
            %% LBP Paper
            if j + tam_ventana <= length(classify_this_object)
                LBP_paper_test(i,j) = lbp_paper(classify_this_object(j:j+tam_ventana-1));
            else
                LBP_paper_test(i,j) = lbp_paper(classify_this_object(j:end));
            end
            
            %% Moda
            moda_test(i,j) = mode(classify_this_object(j:end));
            
            %% Energia
            energia_test(i,j) = sum(classify_this_object(j:end).^2);
            
            %% Potencia
            potencia_test(i,j)=sum(classify_this_object(j:end).^2)/length(classify_this_object(j:end));
            
            %% Maximos y Minimos Ventanales
            max_locales_test(i,j) = max(classify_this_object(j:end));
            min_locales_test(i,j) = min(classify_this_object(j:end));
            
        end
        
    end
    
    for j = 1 : length(classify_this_object) - tam_ventana
        %% LBP
        if j < mod(length(classify_this_object),tam_ventana)
            valores = classify_this_object(1:mod(length(classify_this_object),tam_ventana)+j-1);
            relleno = zeros(1,tam_ventana-mod(length(classify_this_object),tam_ventana)-j+1);
            vector = [relleno valores];
            LBP_test((i-1)*(tam_ventana*2-2)+1:(tam_ventana*2-2)*(i-1)+(tam_ventana*2-2),j)= lbp(vector)';
        else
            LBP_test((i-1)*(tam_ventana*2-2)+1:(tam_ventana*2-2)*(i-1)+(tam_ventana*2-2),j) = lbp(classify_this_object(j-mod(length(classify_this_object),tam_ventana)+1:j-mod(length(classify_this_object),tam_ventana)+1+tam_ventana-1))';
        end
    end
    
end

%% Creacion de ficheros con las caracteristicas de test
csvwrite('Feature_1_Lighting2_Test.dat',identity_map_test);
csvwrite('Feature_2_Lighting2_Test.dat',frecuencia_inst_test);
csvwrite('Feature_3_Lighting2_Test.dat',primera_derivada_test);
csvwrite('Feature_4_Lighting2_Test.dat',segunda_derivada_test);
csvwrite('Feature_5_Lighting2_Test.dat',desviacion_estandar_test);
csvwrite('Feature_6_Lighting2_Test.dat',media_test);
csvwrite('Feature_8_Lighting2_Test.dat',LBP_test);
csvwrite('Feature_9_Lighting2_Test.dat',SWD_test);
csvwrite('Feature_10_Lighting2_Test.dat',mediamovil_test);
csvwrite('Feature_11_Lighting2_Test.dat',suma_acum_test);
csvwrite('Feature_12_Lighting2_Test.dat',varianza_test);
csvwrite('Feature_13_Lighting2_Test.dat',primera_derivada_diff_test);
csvwrite('Feature_14_Lighting2_Test.dat',segunda_derivada_diff_test);
csvwrite('Feature_15_Lighting2_Test.dat',LBP_paper_test);
csvwrite('Feature_16_Lighting2_Test.dat',corr_primera_derivada_test);
csvwrite('Feature_17_Lighting2_Test.dat',corr_segunda_derivada_test);
csvwrite('Feature_18_Lighting2_Test.dat',corr_primera_derivada_diff_test);
csvwrite('Feature_19_Lighting2_Test.dat',corr_segunda_derivada_diff_test);
csvwrite('Feature_20_Lighting2_Test.dat',autocorr_primera_derivada_diff_test);
csvwrite('Feature_21_Lighting2_Test.dat',autocorr_segunda_derivada_diff_test);
csvwrite('Feature_22_Lighting2_Test.dat',maximos_test);
csvwrite('Feature_23_Lighting2_Test.dat',local_fluc_test);
csvwrite('Feature_24_Lighting2_Test.dat',q_RMS_test);
csvwrite('Feature_25_Lighting2_Test.dat',DEP_test);
csvwrite('Feature_26_Lighting2_Test.dat',tf_test);
csvwrite('Feature_27_Lighting2_Test.dat',moda_test);
csvwrite('Feature_28_Lighting2_Test.dat',energia_test);
csvwrite('Feature_30_Lighting2_Test.dat',potencia_test);
csvwrite('Feature_31_Lighting2_Test.dat',autocorr_primera_derivada_test);
csvwrite('Feature_32_Lighting2_Test.dat',autocorr_segunda_derivada_test);
csvwrite('Feature_33_Lighting2_Test.dat',anchura_pico_max_test);
csvwrite('Feature_34_Lighting2_Test.dat',pos_pico_max_test);
csvwrite('Feature_35_Lighting2_Test.dat',anchura_pico_max_test);
csvwrite('Feature_36_Lighting2_Test.dat',max_locales_test);
csvwrite('Feature_37_Lighting2_Test.dat',min_locales_test);