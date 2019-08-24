%% Funcion para cargar los ficheros con los datos de las caracteristicas de test
% Input: Identificador de la funcion a cargar
% Output: Matriz con los datos de la caracteristica cargada

function [funcion_cargada] = cargar_funcion_test(numero_funcion)

%% Switch en funcion del numero de caracteristica a cargar
switch numero_funcion
    case 1
        funcion_cargada=load ('../../DatosLight2/Feature_1_Lighting2_Test.dat');
    case 2
        funcion_cargada=load ('../../DatosLight2/Feature_2_Lighting2_Test.dat');
    case 3
        funcion_cargada=load ('../../DatosLight2/Feature_3_Lighting2_Test.dat');
    case 4
        funcion_cargada=load ('../../DatosLight2/Feature_4_Lighting2_Test.dat');
    case 5
        funcion_cargada=load ('../../DatosLight2/Feature_5_Lighting2_Test.dat');        
    case 8
        funcion_cargada=load ('../../DatosLight2/Feature_8_Lighting2_Test.dat');        
    case 9
        funcion_cargada=load ('../../DatosLight2/Feature_9_Lighting2_Test.dat');        
    case 10
        funcion_cargada=load ('../../DatosLight2/Feature_10_Lighting2_Test.dat');        
    case 11
        funcion_cargada=load ('../../DatosLight2/Feature_11_Lighting2_Test.dat');
    case 12
        funcion_cargada=load ('../../DatosLight2/Feature_12_Lighting2_Test.dat');
    case 13
        funcion_cargada=load ('../../DatosLight2/Feature_13_Lighting2_Test.dat');
    case 14
        funcion_cargada=load ('../../DatosLight2/Feature_14_Lighting2_Test.dat');
    case 15
        funcion_cargada=load ('../../DatosLight2/Feature_15_Lighting2_Test.dat');        
    case 16
        funcion_cargada=load ('../../DatosLight2/Feature_16_Lighting2_Test.dat');        
    case 17
        funcion_cargada=load ('../../DatosLight2/Feature_17_Lighting2_Test.dat');        
    case 18
        funcion_cargada=load ('../../DatosLight2/Feature_18_Lighting2_Test.dat');         
    case 19
        funcion_cargada=load ('../../DatosLight2/Feature_19_Lighting2_Test.dat');        
    case 20
        funcion_cargada=load ('../../DatosLight2/Feature_20_Lighting2_Test.dat');        
    case 21
        funcion_cargada=load ('../../DatosLight2/Feature_21_Lighting2_Test.dat');           
    case 22
        funcion_cargada=load ('../../DatosLight2/Feature_22_Lighting2_Test.dat');
    case 23
        funcion_cargada=load ('../../DatosLight2/Feature_23_Lighting2_Test.dat');
    case 24
        funcion_cargada=load ('../../DatosLight2/Feature_24_Lighting2_Test.dat');
    case 25
        funcion_cargada=load ('../../DatosLight2/Feature_25_Lighting2_Test.dat');        
    case 26
        funcion_cargada=load ('../../DatosLight2/Feature_26_Lighting2_Test.dat');        
    case 27
        funcion_cargada=load ('../../DatosLight2/Feature_27_Lighting2_Test.dat');        
    case 28
        funcion_cargada=load ('../../DatosLight2/Feature_28_Lighting2_Test.dat');               
    case 30
        funcion_cargada=load ('../../DatosLight2/Feature_30_Lighting2_Test.dat');        
    case 31
        funcion_cargada=load ('../../DatosLight2/Feature_31_Lighting2_Test.dat');          
    case 32
        funcion_cargada=load ('../../DatosLight2/Feature_32_Lighting2_Test.dat');
    case 33
        funcion_cargada=load ('../../DatosLight2/Feature_33_Lighting2_Test.dat');
    case 34
        funcion_cargada=load ('../../DatosLight2/Feature_34_Lighting2_Test.dat');
    case 35
        funcion_cargada=load ('../../DatosLight2/Feature_35_Lighting2_Test.dat');        
    case 36
        funcion_cargada=load ('../../DatosLight2/Feature_36_Lighting2_Test.dat');        
    case 37
        funcion_cargada=load ('../../DatosLight2/Feature_37_Lighting2_Test.dat');               
end