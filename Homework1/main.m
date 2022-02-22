clear; clc; close all; 

% Define the angular velocity and the radius of the Earth as global variables 
global R_e
global theta_dot 
R_e = 6371;  %[km]
theta_dot = 2*pi/86400;

% Initial data 

lambda = deg2rad(40);                    % Latitude (40 deg) 
r1 = [-339191,-982468,55572.6];         % Position vector in S1 [km]
v1 = [46.5606, -16.8690, -54.8913];     % Velocity vector in S1 [km/s]
t_0 = 16200;                            % Time from 13:30 until 18:00 [s]
% Exercise 1
[r0, v0] = SEZ2ECI(r1,v1,R_e, lambda,t_0); 





