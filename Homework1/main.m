% Álvaro Reviriego Moreno & Enrique Sentana Gómez
% Orbital Mechanics. Homework 1

clear; clc; close all; 

% Define the angular velocity and the radius of the Earth as global variables 
global R_e
global theta_dot
global muE

muE = 398600;
R_e = 6371;  %[km]
theta_dot = 2*pi/86400;

% Initial data 

lambda = deg2rad(40);                    % Latitude (40 deg) 
r1 = [-339191,-982468,55572.6];         % Position vector in S1 [km]
v1 = [46.5606, -16.8690, -54.8913];     % Velocity vector in S1 [km/s]
t_0 = 16200;                            % Time from 13:30 until 18:00 [s]
% Exercise 1
%[r0, v0] = SEZ2ECI(r1,v1,R_e, lambda,t_0); 

% Prueba la funcion rv2coe con el ejercicio 11 de clase 
r0 = [-6045,-3490,2500]; 
v0 = [-3.457,6.618,2.538]; 

% Exercise 2
[a,e,RAAN,i,omega,theta] = rv2coe(r0,v0);

omega = rad2deg(omega); 
RAAN = rad2deg(RAAN);
i = rad2deg(i); 
theta = rad2deg(theta); 



