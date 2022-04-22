% Álvaro Reviriego Moreno & Enrique Sentana Gómez
% Orbital Mechanics. Homework 1

clear; clc; close all; 

% Define the global variables 

muE = 398600;                                          % Gravitational constant of the Earth [kg*km^3/s]
R_e = 6371;                                            % Earth radius [km]
angular_rate = 2*pi/86400;                             % Angular rate of the Earth about its rotation axis [rad/s]

%% Initial data 

lambda = deg2rad(40);                                  % Latitude (40 deg) 
r1 = [-735761,506988,-540928];                         % Position vector in S1 [km]
v1 = [25.3451, 62.8133, 29.5876];                      % Velocity vector in S1 [km/s]
t_0 = 16200;                                           % Time from 13:30 until 18:00 [s]

%% Exercise 1
[r0, v0] = SEZ2ECI(r1,v1,R_e, lambda,t_0); 

%% Exercise 2

coe = stat2coe([r0,v0],muE);

a = coe(1); 
e = coe(2); 
i = coe(3); 
RAAN = coe(4); 
omega = coe(5); 
theta = coe(6); 

% Change the angles from rad to deg (optional)
% omega = rad2deg(omega); 
% RAAN = rad2deg(RAAN);
% i = rad2deg(i); 
% theta = rad2deg(theta); 

theta_inf = acos(-1/e); % True anomaly of the asymptotes
beta = pi-theta_inf; % [rad]
delta = pi -2*beta; % Turning angle
B = -e*a*sin(beta); % Impact parameter
vH = sqrt(-muE/a);  % Excess hyperbolic velocity [km/s]

%% Exercise 3
H = True2EccH(theta, e);
M_h = e*sinh(H) - H; 
n_h = sqrt(-muE/(a^3)); 
t_periapsis = -M_h/n_h; 

% Compute the position and velocity at 90h
t_90 = 90*3600;                                         % 90 hours 
M_h90 = n_h*(t_90 - t_periapsis);                       % Mean anomaly at 90h

H_90 = Mean2EccH(M_h90,e);
theta_90 = Ecc2TrueH(H_90,e);

X = coe2stat([a,e,i,RAAN,omega,theta_90],muE);
r_90 = X(1:3);                      % Position vector in ECI
v_90 = X(4:6);                      % Velocity vector in ECI 

[r_90_1,v_90_1] = ECI2SEZ(r_90,v_90,R_e,lambda,t_0 + t_90); 

%% Exercise 4

% Part A - Elliptic orbit 
e_A = 0.7; 
theta_A = deg2rad(-110); 
v_A = 0.5*norm(v_90); 
r_A = norm(r_90);

a_A = muE/(2*(muE/r_A)-(v_A^2));

% As the body A is in the same plane as the initial one, the rest of the
% COEs will be the same 
i_A = i;
RAAN_A = RAAN; 
omega_A = omega; 

% Once the elliptic orbit A is calculated, one may find the state vector 
X_A = coe2stat([a_A,e_A,i_A,RAAN_A, omega_A,theta_A],muE);

% Unpack the state vector into position and velocity 
r_A_0 = X_A(1:3); 
v_A_0 = X_A(4:6); 

% By conservation of linear momentum 
r_B_0 = r_A_0; 
v_B_0 = v_90 - 0.5*v_A_0;

% Get the COEs from the state vector 
coeB = stat2coe([r_B_0,v_B_0],muE); 

a_B = coeB(1);
e_B = coeB(2);
i_B = coeB(3); 
RAAN_B = coe(4); 
omega_B = coe(5); 
theta_B = coe(6); 

%% Exercise 5
% Calculate apoapsis (rF) and periapsis (rA) and use Eq 2.7 
rA = a_A*(1-e_A);
rF = a_A*(1+e_A); 

deltaV = sqrt(muE/rF) - sqrt((2*muE/rF)-(2*muE/(rA+rF))); 



