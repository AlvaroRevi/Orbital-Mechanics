clc;
clear;

% Parameters
e = 0.1;
a = 18000; %km
theta = deg2rad(20); % True anomally at t=0
mu = 3.986e5;

thetas = [40 60 80 100 120 140 160 180 200];

E = True2Ecc(thetas, e);
Me = Ecc2Mean(E, e);
t = Me/sqrt(mu/(a^3));