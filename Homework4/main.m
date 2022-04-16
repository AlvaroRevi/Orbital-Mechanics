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


%% Exercise c

N = 200;
n = sqrt(mu/a^3);
time = linspace(0,2*pi/n,N);

Hp = 4.4e-2;
H_G0 = [0;Hp;I_g*n];

for i=1:N
    angles(2) = n*t(i);
    omega_b0 = nominal(mu,a,e,w,nu);
    [omegaA(i),omegaB(i),omegaC(i)] = wheels(w,nu,angles,omega_b0,H_G0);
end

figure
hold on
plot(t,omegaA)
plot(t,omegaB)
plot(t,omegaC)
xlabel('$time$','Interpreter','latex','FontSize',18)
ylabel('$\omega_{wheel}$','Interpreter','latex','FontSize',18)
legend('$\omega_{A}$','$\omega_{B}$','$\omega_{C}$','Interpreter','latex')
hold off

