function [train,test] = reparte(series,p,i)
%p es el numero de particiones
%i es la particion que se va a usar para test, el resto sera para train

tam = size (series,1);
delta = floor(tam/p);

if (i==p)
	test = series((i-1)*delta+1:end,:);
	train = series(1:(i-1)*delta,:);
else
	test = series((i-1)*delta+1:i*delta,:);
	train = [series(i:(i-1)*delta,:); series(i*delta+1:end,:)];
end
