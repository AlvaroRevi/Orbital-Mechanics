clear; clc; close all; 

% Data of the cylinder 
M = 50; 
R = 0.25; 
L = 0.1; 

% Tensor of inertia of the cylinder 
Iz = 0.5*M*R^2; 
Iy = 0.5*Iz + (1/12)*M*L^2; 
Ix = Iy; 


angles = [0;0.08755337349;0];

I_basisb = diag([Ix,Iy,Iz]);
omegab0_basisb = [0;pi/36;pi/6]; 
% omegab0_basisb = [0;0;pi/6]; % Stable spin wb0 (no perturbation in jb)

y0 = [angles;omegab0_basisb];

[t,Y] = ode45(@(t,X) derattitude2(t,X,Ix,Iy,Iz), linspace(0,100,1000), y0); 

figure(1) 
hold on 
grid minor 
plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))
xlabel('Time [s]','Interpreter','latex')
ylabel('Angles','Interpreter','latex')
legend('$\psi$','$\theta$','$\phi$','Interpreter','Latex')
