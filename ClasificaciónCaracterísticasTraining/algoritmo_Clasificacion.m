%% Función algoritmo_Clasificacion. Parámtros de entrada -> etiquetas de train, matriz MLFS, mínima long de características, tamaño de la ventana
%% criterio usado, y valores de las características para las instancias de train.
%% Parametros de salida -> La clase predicha
function clase_predicha = algoritmo_Clasificacion(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature1_tr,feature2_tr,feature3_tr,feature4_tr)

        switch nargin
            case 6
                tam_feature = size (feature1_tr);
                if tam_feature(1) <= length(TRAIN_class_labels)
                    clase_predicha = dame_etiqueta(TRAIN_class_labels,matriz,min_long_feat,criterion,feature1_tr);
                else %Caso para LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature1_tr);            
                end
            case 7
                [row1, ~] = size(feature1_tr);
                [row2, ~] = size(feature2_tr);
                if row1 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature1_tr,feature2_tr);
                else if row2 > length(TRAIN_class_labels) %Es la feature de LBP
                        clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature2_tr,feature1_tr);
                        else 
                         clase_predicha = dame_etiqueta(TRAIN_class_labels,matriz,min_long_feat,criterion,feature1_tr,feature2_tr);
                     end
                end

            case 8
            [row1, ~] = size(feature1_tr);
            [row2, ~] = size(feature2_tr);
            [row3, ~] = size(feature3_tr);
               if row1 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature1_tr,feature2_tr,feature3_tr);
               elseif row2 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature2_tr,feature1_tr,feature3_tr);
               elseif row3 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature3_tr,feature1_tr,feature2_tr);
               else 
                    clase_predicha = dame_etiqueta(TRAIN_class_labels,matriz,min_long_feat,criterion,feature1_tr,feature2_tr,feature3_tr);
               end

            case 9
            [row1, ~] = size(feature1_tr);
            [row2, ~] = size(feature2_tr);
            [row3, ~] = size(feature3_tr);
            [row4, ~] = size(feature4_tr);
               if row1 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature1_tr,feature2_tr,feature3_tr,feature4_tr);
               elseif row2 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature2_tr,feature1_tr,feature3_tr,feature4_tr);
               elseif row3 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature3_tr,feature1_tr,feature2_tr,feature4_tr);
               elseif row4 > length(TRAIN_class_labels) %Es la feature de LBP
                    clase_predicha = dame_etiqueta_lbp(TRAIN_class_labels,matriz,min_long_feat,window,criterion,feature4_tr,feature1_tr,feature2_tr,feature3_tr);
                    else 
                    clase_predicha = dame_etiqueta(TRAIN_class_labels,matriz,min_long_feat,criterion,feature1_tr,feature2_tr,feature3_tr,feature4_tr);
               end

        end
          
    end