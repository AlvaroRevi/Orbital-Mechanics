clear; clc; close all; 
%%%%%%%%% Homework 4 
% Initial data 
h_orbit = 600;              % Altitude of the orbit [km]
e = 0.1;                     % Eccentricity [-]
I_g = diag([220,180,300]);  % Inertia tensor in b basis. [kg m^2]
R_e = 6371;                 % Radius of the earth [km]
mu = 3.986e5; 



%% Exercise a 
a = R_e + h_orbit; 

% As it is an equatorial orbit, vector w pointing along h is [0,0,1]
 w = [0,0,1];

 nu = linspace(0,2*pi,360); 
 
 for i = 1:length(nu)
 omega_b0(:,i) = nominal(mu,a,e,w,nu(i));
 end 

figure(1)
hold on 
plot(nu,omega_b0(1,:))
plot(nu,omega_b0(2,:))
plot(nu,omega_b0(3,:))
ylim([-1.5e-3,1.5e-3])
xlabel('$\theta$','Interpreter','latex','FontSize',18)
ylabel('$\omega_{b0}$','Interpreter','latex','FontSize',18)
legend('$\vec i_{0}$','$\vec j_{0}$','$\vec k_{0}$','Interpreter','latex')


%% Exercise b 


