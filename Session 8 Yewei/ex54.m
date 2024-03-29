
clc;
clear;
close all

I_basisb = diag([4000, 7500, 8500]);

angles = [0; pi/2; 0];

omegab0_basisb = [0.1; -0.2; 0.5];

H_basisb = I_basisb*omegab0_basisb;

oRb = rot3(3,angle(1))*rot3(1,angles(2))*rot3(3,angles(3)); 
omegab0_basis0 = oRb*omegab0_basisb; 

[t,Y] = ode45(@(t,X) derangles(X,omegab0_basisb), linspace(0,100,1000), angles); 

figure(1) 
hold on 
grid minor 
plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))
xlabel('Time [s]','Interpreter','latex')
ylabel('Angles','Interpreter','latex')
legend('$\psi$','$\theta$','$\phi$','Interpreter','Latex')





