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
    omega_b0(:,i) = nominal_hw(mu,a,e,w,nu(i));
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
% dangles_dt = dangles_dt(mu,a,e,w,nu,angles,omega_b0);

%% Exercise c

N = 720;
n = sqrt(mu/a^3);
timespan = linspace(0,4*pi/n,N);
nu = linspace(0,4*pi,N); 

Hp = 4.4e-2;
H_G0_aux = I_g*n*[0 0 1]' ;

H_G0 = [0;Hp;0] + H_G0_aux;

for i=1:N
    angles(1) = 0;
    angles(2) = n*timespan(i);
    angles(3) = 0;

    omega_b0 = nominal_hw(mu,a,e,w,nu(i));
    [omegaA(i),omegaB(i),omegaC(i)] = wheels(w,nu(i),angles,omega_b0,H_G0);
end

figure
hold on
grid minor
plot(timespan,omegaA)
plot(timespan,omegaB)
plot(timespan,omegaC)
xlabel('$time$','Interpreter','latex','FontSize',18)
ylabel('$\omega_{wheel}$','Interpreter','latex','FontSize',18)
legend('$\omega_{A}$','$\omega_{B}$','$\omega_{C}$','Interpreter','latex')
hold off

%% Exercise d
omega_b0 = broken(w,nu(1),angles0,H_G0);

[t,Y] = ode45(@(t,angles) dangles_dt(mu,a,e,w,nu(1),angles,omega_b0), timespan, angles0); 

figure(3) 
hold on 
grid minor 
plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))
xlabel('Time [s]','Interpreter','latex')
ylabel('Angles','Interpreter','latex')
legend('$\psi$','$\theta$','$\phi$','Interpreter','Latex')