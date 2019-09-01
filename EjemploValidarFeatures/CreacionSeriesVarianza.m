%% Parametros series de prueba para la feature 13 (Varianza)
% rand=0.5301 series=20 clase1=11 clase-1=9 %Longitud instancias = 201

clase1=11;
instancias = zeros (20,201);

for j=1:20
    if j <= clase1 %Instancias de clase1 (señal aleatoria con valores entre 100 y -100)
        instancias(j,1)=1;
        instancias (j,2:end) = (rand(1,200)-rand(1,200))*100;
    else  %Instancias de clase-1 (señal aleatoria con valores entre 1 y -1)
        instancias(j,1)=-1;
        instancias (j,2:end) = rand(1,200)-rand(1,200);
    end   
end

indices = randperm(20);
instancias=instancias(indices',:);
csvwrite('SeriesValidarVarianza.dat',instancias);