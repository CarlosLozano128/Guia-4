% 1 Funciones polyfit y polyval
% polyfit: Sirve para ajustar un polinomio a un conjunto de datos mediante el método de mínimos cuadrados.
% polyval: Sirve para evalúar un polinomio en un conjunto de puntos dados.

% 2. Cargar la base de datos census
load census; % Carga la base de datos 

% La base de datos "census" contiene información sobre la población de EE. UU. en años específicos

% 3 Ajuste polinomial de curvas
p1 = polyfit(cdate,pop,1); 
p2 = polyfit(cdate,pop,2);
p3 = polyfit(cdate,pop,3); 

% 4 Graficar datos y ajustes polinomiales
scatter(cdate, pop); % Grafica los datos de población
hold on;
fplot(@(x) polyval(p1,x), [min(cdate), max(cdate)], 'r'); 
fplot(@(x) polyval(p2,x), [min(cdate), max(cdate)], 'g'); 
fplot(@(x) polyval(p3,x), [min(cdate), max(cdate)], 'b'); 
hold off;
legend('Datos', 'Ajuste Lineal', 'Ajuste Cuadrático', 'Ajuste Cúbico');
xlabel('Año');
ylabel('Población');
title('Ajuste Polinomial de Curvas a Datos de Población de EE.UU');
%Ajusta el grado en los datos
y1 = polyval(p1, cdate); 
y2 = polyval(p2, cdate);
y3 = polyval(p3, cdate); 
% 5 Calcular error cuadrático medio para ajuste de cada una con la formula "MSE= 1/n ∑i=1n (yi− y^i)^2
mse1 = mean((pop - y1).^2); 
mse2 = mean((pop - y2).^2); 
mse3 = mean((pop - y3).^2); 

%Resultados
fprintf('Error cuadrático medio para ajuste grado 1: %.2f\n', mse1);
fprintf('Error cuadrático medio para ajuste grado 2: %.2f\n', mse2);
fprintf('Error cuadrático medio para ajuste grado 3: %.2f\n', mse3);

