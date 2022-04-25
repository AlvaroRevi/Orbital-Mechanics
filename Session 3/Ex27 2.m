clear; clc; close all 
% Exercise 27 

% Define the global variables 
global R_e
global angular_rate
global muE

muE = 398600;                   % Gravitational constant of the Earth [kg*km^3/s]
R_e = 6371;  %[km]              % Earth radius [km]
angular_rate = 2*pi/86400;      % Angular rate of the Earth about its rotation axis [rad/s]

time = 2*3600;                  % Time passed since Greenwich meridian crossed the i0 direction [s]

varphi = angular_rate*time;     % Angle between i1 (ECEF) and i0 (ECI) 

% Position of the Ground Station 
phi = deg2rad(40.3320);          % Latitude of the GS[rad]
lambda = deg2rad(-3.7687);       % Longitude of the GS with respect to ECEF [rad]
r_GS = 6371 + 0.6;               % Radius of the GS [km]

longitud = varphi + lambda;      % Longitud of the GS with respect to ECI [rad]

% Measurements from the Ground Station (SEZ reference frame)  
rho = 2793.1; 
rho_dot = 2.9453; 
beta = deg2rad(78.2); 
beta_dot = deg2rad(-0.0984); 
eps = deg2rad(25.8); 
eps_dot = deg2rad(-0.1075); 

% Compute position vector of the GS in ECEF basis (S1) 
r_GS_1 = r_GS*[cos(phi)*cos(lambda),
               cos(phi)*sin(lambda), 
               sin(phi)];

% Compute position vector in SEZ 
r_SC_2 = [-rho*cos(eps)*cos(beta), 
           rho*cos(eps)*sin(beta), 
           rho*sin(eps)]; 
   
v_SC_2 = [-rho_dot*cos(eps)*cos(beta) + rho*eps_dot*sin(eps)*cos(beta) + rho*beta_dot*cos(eps)*sin(beta), 
          rho_dot*cos(eps)*sin(beta) - rho*eps_dot*sin(eps)*sin(beta) + rho*beta_dot*cos(eps)*cos(beta), 
          rho_dot*sin(eps) + rho*eps_dot*sin(eps)]; 

[r0,v0] = SEZ2ECI_ez27(r_SC_2,v_SC_2,r_GS,phi,time, lambda); 

[a,e,RAAN,i,omega,theta] = rv2coe(r0,v0); 

i = rad2deg(i); 
omega = rad2deg(omega); 
RAAN = rad2deg(RAAN); 
theta = rad2deg(theta); 

   
 
