clc;
clear;
close all

%% First part
% theta --> E --> Me --> t (easy)

% Parameters
e = 0.4;
a = 20000; %km
theta = deg2rad(45);
mu = 3.986e5;

E = True2Ecc(theta, e);
Me = Ecc2Mean(E, e);
t = Me/((mu/(a^3))^(1/2));

%% Second part
% t --> Me(numerical solver)---> E ---> theta (difficult)

t_tot = t + 40*60;
Me2 = ((mu/(a^3))^(1/2))*t_tot;
E2 = Mean2Ecc(Me2,e);
theta2 = rad2deg(Ecc2True(E2,e));

fprintf('True anomaly: %.f\n',theta2)

