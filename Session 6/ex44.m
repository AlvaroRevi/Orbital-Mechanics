% Enrique Sentana Gómez & Álvaro Reviriego Moreno
% Ex44

clc;
clear;
close all

mu_mars = 0.428284e5;
mu_sun = 1327120e5;

a_earth = 149.67e6;
a_mars = 227.94e6;

T = 4*3600;

% a) Target science orbit of pericenter radius rsp
r_sp = (mu_mars*(T/(2*pi))^2)^(1/3); % [km]

% b) Arrival orbit
v2P_ah = sqrt(mu_sun/a_mars)*(1-sqrt(2*a_earth/(a_earth+a_mars))); % [km/s]

aa = -mu_mars/(v2P_ah^2); % [km]
ea = 1+ r_sp*(v2P_ah^2)/mu_mars;

% c) Capture impulse
v2P_ap = sqrt(mu_mars*(1+ea)/(aa*(1-ea))); % [km/s]
V2P_sp = sqrt(mu_mars/r_sp); % [km/s]

deltaV = v2P_ap - V2P_sp; % [km/s]