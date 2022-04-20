clear; clc; close all; 
% Ex 42

mu = 1327120e5; 

a_E = 149.67e6; 
a_M = 227.94e6; 

n_fun = @(a) sqrt(mu/(a^3)); 
n_E = n_fun(a_E);
n_M = n_fun(a_M);

delta_n = n_M - n_E; 

% Synodic period 
tau_s = (2*pi/abs(delta_n))/(24*3600*365); 

% Hohmann transfer orbit
a_t = 0.5*(a_E + a_M); 

e_t = 1 - (a_E/a_t);

% S/C velocities to Sun 
v_0tp = sqrt((2*mu/(a_E + a_M))*(a_M/a_E)); 
v_0ta = sqrt((2*mu/(a_E + a_M))*(a_E/a_M)); 

% Transfer time 
t_transfer = pi*sqrt((a_t^3)/mu); 

% Initial relative phase angles 
phi_1 = pi - n_M*t_transfer; 
phi_2 = pi - n_E*t_transfer; 



