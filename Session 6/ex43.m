clear; clc; close all; 
% Ex43 
mu_E = 3.986e5; 
mu_S = 1327120e5;

Re = 6371;
rc = Re + 300; 

a_E = 149.67e6;  
a_M = 227.94e6; 

v1p_eh = sqrt(mu_S/a_E)*(sqrt(2*a_M/(a_E+a_M))-1);

% Escape orbit 
a_e = -mu_E/(v1p_eh^2); 
e_e = 1 + rc*(v1p_eh^2)/mu_E; 

% Speed of the periapsis of the hyperbola 
v1_ep = sqrt(mu_E*(1+e_e)/(a_e*(1-e_e))); 

% Speed of P in the circular parking orbit 
v1_cc = sqrt(mu_E/rc); 

delta_V = v1_ep - v1_cc; 