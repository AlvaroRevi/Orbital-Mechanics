% Álvaro Reviriego Moreno & Enrique Sentana Gómez
% Orbital Mechanics. Homework 1

clear; clc; close all; 

% Define the global variables 
global R_e
global angular_rate
global muE

muE = 398600;                   % Gravitational constant of the Earth [kg*km^3/s]
R_e = 6371;  %[km]              % Earth radius [km]
angular_rate = 2*pi/86400;         % Angular rate of the Earth about its rotation axis [rad/s]

%% Initial data 

lambda = deg2rad(40);                   % Latitude (40 deg) 
r1 = [-735761,506988,-540928];         % Position vector in S1 [km]
v1 = [25.3451, 62.8133, 29.5876];     % Velocity vector in S1 [km/s]
t_0 = 16200;                            % Time from 13:30 until 18:00 [s]

%% Exercise 1
[r0, v0] = SEZ2ECI(r1,v1,R_e, lambda,t_0); 

%% Exercise 2
[a,e,RAAN,i,omega,theta] = rv2coe(r0,v0);

% Change the angles from rad to deg (optional)
% omega = rad2deg(omega); 
% RAAN = rad2deg(RAAN);
% i = rad2deg(i); 
% theta = rad2deg(theta); 

theta_inf = acos(-1/e); % True anomaly of the asymptotes
beta = pi-theta_inf; % [rad]

delta = pi -2*beta; % Turning angle
B = -e*a*sin(beta); % Impact parameter
vH = sqrt(-muE/a); % Excess hyperbolic velocity [km/s]

%% Exercise 3
H = True2EccH(theta, e);
M_h = e*sinh(H) - H; 
eta_H = sqrt(-muE/(a^3)); 
t_periapsis = -M_h/eta_H; 

[r0_3, v0_3] = SEZ2ECI(r1,v1,R_e, lambda,t_periapsis);
[r1_3,v1_3] = ECI2SEZ(r0_3,v0_3,R_e,lambda,t_periapsis);

%% Exercise 4




%% Exercise 5




