% Enrique Sentana & Álvaro Reviriego
% Exercise 51

clc;
clear;
close all

% Earth
xJ = 1;
mJ = 1.898e27;

% Sun
xS = 0;
mS = 1.989e30;

mu = mJ/mS; % m = mS + mE approx muE
mu = 9.5369e-04; % From prof Zhou

% ws = sqrt(G*mu/L^3);
aux_fun = @(x) -(1-mu)*(x+mu)/abs((x+mu)^3) -mu*(x+mu-1)/abs((x+mu-1)^3) +x;

aux1 = fsolve(@(x) aux_fun(x),0.95);
aux2 = fsolve(@(x) aux_fun(x),1.05);
aux3 = fsolve(@(x) aux_fun(x),-0.9);
aux4 = [(0.5-mu); sqrt(3)/2];
aux5 = [(0.5-mu); -sqrt(3)/2];


U_fun = @(x,y,z) -(1-mu)./sqrt((y.^2)+(z.^2)+(x+mu).^2)-mu./sqrt(y.^2+z.^2+(x+mu-1).^2) -(x.^2+y.^2)./2;

% 0 velocity at L1 and L5
Emin_L1 = U_fun(aux1,0,0);
Emin_L5 = U_fun(aux5(1),aux5(2),0);
Emin = (Emin_L1+Emin_L5)/2;

N = 100;
x = linspace(-3,3,N);
y = linspace(-3,3,N);
[X,Y] = meshgrid(x,y);

%% Contour levels of the potential
figure
hold on
contour(X,Y,U_fun(X,Y,0),[-6 -4 -2 Emin_L1 Emin_L5],'ShowText','on')

plot(-mu,0,'o','MarkerSize',12,'Color','k')
text(-mu,0,'S','FontSize',12)
plot(1-mu,0,'o','MarkerSize',6,'Color','k')
text(1-mu,0,'J','FontSize',12)

plot(aux1,0,'x','MarkerSize',6,'Color','k')
text(aux1,0,'L1')
plot(aux2,0,'x','MarkerSize',6,'Color','k')
%text(aux2,0,'L2')
plot(aux3,0,'x','MarkerSize',6,'Color','k')
%text(aux3,0,'L3')
plot(aux4(1),aux4(2),'x','MarkerSize',6,'Color','k')
%text(aux4(1),aux4(2),'L4')
plot(aux5(1),aux5(2),'x','MarkerSize',6,'Color','k')
text(aux5(1),aux5(2),'L5')
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
hold off

%% 3D Hill's surface
z = linspace(-1,1,N);
[X,Y,Z] = meshgrid(x,y,z);

figure
hold on
plot3(aux1,0,0,x','MarkerSize',6,'Color','k')
plot3(aux2,0,0,'x','MarkerSize',6,'Color','k')
plot3(aux3,0,0,'x','MarkerSize',6,'Color','k')
plot3(aux4(1),aux4(2),0,'x','MarkerSize',6,'Color','k')
plot3(aux5(1),aux5(2),0,'x','MarkerSize',6,'Color','k')
isosurface(X,Y,Z,U_fun(X,Y,Z),Emin_L1)
alpha(0.25)

axis equal
hold off

%% Plot basico
figure
hold on
grid minor
%fplot(aux_fun,'b')
%plot([-10 10],[0 0],'k')
plot(xS,0,'ok','MarkerFaceColor','y','MarkerSize',10);
plot(xJ,0,'ok','MarkerFaceColor','#EDB120','MarkerSize',5)
plot(aux1,0,'r*','MarkerSize',5) 
plot(aux2,0,'g*','MarkerSize',5)
plot(aux3,0,'b*','MarkerSize',5)
plot(aux4(1),aux4(2),'*','MarkerSize',5)
plot(aux5(1),aux5(2),'*','MarkerSize',5)
xlim([-1.5 1.5])
ylim([-1.5 1.5])
xlabel('$x/L$','Interpreter','latex')
ylabel('$y/L$','Interpreter','latex')
legend('Sun','Jupiter','L1','L2','L3','L4','L5')
hold off