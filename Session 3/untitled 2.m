clear; clc; close all; 

rho = 2793.1; 
rho_dot = 2.9453; 
beta = deg2rad(78.2); 
beta_dot = deg2rad(-0.0984); 
eps = deg2rad(25.8); 
eps_dot = deg2rad(-0.1075); 

% Compute position vector in SEZ 
r_SC_2 = [-rho*cos(eps)*cos(beta), 
           rho*cos(eps)*sin(beta), 
           rho*sin(eps)]; 
   
v_SC_2 = [-rho_dot*cos(eps)*cos(beta) + rho*eps_dot*sin(eps)*cos(beta) + rho*beta_dot*cos(eps)*sin(beta), 
          rho_dot*cos(eps)*sin(beta) - rho*eps_dot*sin(eps)*sin(beta) + rho*beta_dot*cos(eps)*cos(beta), 
          rho_dot*sin(eps) + rho*eps_dot*sin(eps)]; 

rho = 2793.1; % [km]
drho = 2.9453; % [km/s]
beta = deg2rad(78.2); % [rad]
dbeta = deg2rad(-0.0984); % [rad/s]
epsilon = deg2rad(25.8); % [rad]
depsilon = deg2rad(-0.1075); % [rad/s]

v2p_SEZ = [-drho*cos(epsilon)*cos(beta)+rho*depsilon*sin(epsilon)*cos(beta)+rho*dbeta*cos(epsilon)*sin(beta)...
     drho*cos(epsilon)*sin(beta)-rho*depsilon*sin(epsilon)*sin(beta)+rho*dbeta*cos(epsilon)*cos(beta)...
     drho*sin(epsilon)+rho*depsilon*sin(epsilon)]'; %[km/s]