% Enrique Sentana & Álvaro Reviriego
% Exercise 49

clc;
clear;
close all

% Earth
xE = 1;
mE = 5.97219e24;

% Sun
xS = 0;
mS = 1.989e30;

m = mE/mS; % m = mS + mE approx muE

% ws = sqrt(G*mu/L^3);
aux_fun = @(x) -(1-m)*(x+m)/abs((x+m)^3) -m*(x+m-1)/abs((x+m-1)^3) +x;

aux1 = fsolve(@(x) aux_fun(x),0.95);
aux2 = fsolve(@(x) aux_fun(x),1.05);
aux3 = fsolve(@(x) aux_fun(x),-0.9);

figure
hold on
grid minor
fplot(aux_fun,'b')
plot([-10 10],[0 0],'k')
plot(xS,0,'ok','MarkerFaceColor','y','MarkerSize',20);
plot(xE,0,'ok','MarkerFaceColor','b','MarkerSize',10)
plot(aux1,0,'r*','MarkerSize',10) 
plot(aux2,0,'r*','MarkerSize',10)
plot(aux3,0,'r*','MarkerSize',10)
xlim([-1.5 1.5])
ylim([-2 2])
xlabel('$x/L$','Interpreter','latex')
ylabel('$\partial U/\partial x$','Interpreter','latex')
hold off