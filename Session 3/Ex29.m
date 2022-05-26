clear;
clc;
close all

%% Problem data
% Earth
muE = 3.986e5;

% S/C vectors in ECI
r1 = [15945.34 0 0];                % [km]
r2 = [12214.83899 0 10249.64731];   % [km]

% Time span between the 2 observations
Dt = 76*60;                        % [s]

%% Compute short and long arc solutions
% Short arc
[a_s,e_s,Omega_s,i_s,omega_s,theta1_s,theta2_s] = Lambert_solve(muE,r1,r2,Dt,cross(r1,r2)/norm(cross(r1,r2)));

% Long arc
[a_l,e_l,Omega_l,i_l,omega_l,theta1_l,theta2_l] = Lambert_solve(muE,r1,r2,Dt,-cross(r1,r2)/norm(cross(r1,r2)));

%% Explore how solutions change if Dt modified from 30-240 min