%%%%%%%%% Enrique Sentana and Alvaro Reviriego 
%%%%%%% Homework 2 
clear; clc; close all; 

% Orbital elements 
a = 5940;                       % Semi-major axis [km]
e= 0.4;                         % Eccentricity 
Omega = deg2rad(194);           % RAAN 
i = deg2rad(56);                % Inclination 
omega = deg2rad(258);           % Argument of perigee 

theta_0 = deg2rad(230);         % True anomaly at t=0 
S = 10;                         % Shield area [m^2]
m = 3000;                       % Mass of the spacecraft [kg]

mu = 0.428284e5; % Gravitational parameter in Mars [km^3/s^2]

X = coe2stat([a,e,i,Omega,omega,theta_0],mu);
X(3)
%% Exercise e

flag = false;
tf = 90*24*3600;

dt1 = 300;
t1 = 0:dt1:tf;
X1 = RK4(X,dt1,flag);

dt2 = 150; 
t2 = 0:dt2:tf;
X2 = RK4(X,dt2,flag);

dt3 = 75;
t3 = 0:dt3:tf; 
X3 = RK4(X,dt3,flag);

dt4 = 37.5;
t4 = 0:dt4:tf;
X4 = RK4(X,dt4,flag);

figure 
hold on
grid minor


hold off

%% Exercise f
X4 = RK4(X,dt4,true);

for k=1:length(X4(1,:))
    if norm(X4(1:3,k))<50
        return
    end
    [a4(k),e4(k),RAAN4(k),i4(k),omega4(k),theta4(k)] = rv2coe(X4(1:3,k),X4(4:end,k)); 
end

figure 
hold on
grid minor
plot(t4,a4)
legend('Semi-major axis',Interpreter='latex')
xlabel('time [s]',Interpreter='latex')
ylabel('a [km]',Interpreter='latex')
hold off

figure 
hold on
grid minor
plot(t4,e4)
legend('Eccentriity',Interpreter='latex')
ylabel('e',Interpreter='latex')
xlabel('time [s]',Interpreter='latex')
hold off

figure 
hold on
grid minor
plot(t4,omega4)
legend('Argument of perigee',Interpreter='latex')
ylabel('$\omega$',Interpreter='latex')
xlabel('time [s]',Interpreter='latex')
hold off

%% Exercise g

e = 0;          % Eccentricity = 0 (circular orbit)

