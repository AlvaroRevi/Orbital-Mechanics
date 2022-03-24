% Enrique Sentana Gómez & Álvaro Reviriego Moreno
% Ex43

clc;
clear;
close all

mu_sun = 1327120e5;
mu_earth = 3.986e5;

Re = 6371;
rc = Re + 300;

a_earth = 149.67e6;
a_mars = 227.94e6;

v1P_eh = sqrt(mu_sun/a_earth)*(sqrt(2*a_mars/(a_earth+a_mars))-1); % [km/s]

% a) Escape orbit
ae = -mu_earth/(v1P_eh^2);
ee = 1 + rc*(v1P_eh^2)/mu_earth;

% b) Escape impulse
v1P_cc = sqrt(mu_earth/rc); % [km/s]
v1P_ep = sqrt(mu_earth*(1+ee)/(ae*(1-ee))); % [km/s]

deltaV = v1P_ep-v1P_cc; % [km/s]