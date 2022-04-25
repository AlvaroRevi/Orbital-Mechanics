clc;
clear;
close all

I_basisb = diag([4000, 7500, 8500]);
IR_basisG = diag([50, 50, 100]);

Ix = I_basisb(1,1) + IR_basisG(1,1);
Iy = I_basisb(2,2) + IR_basisG(2,2);
Iz = I_basisb(3,3) + IR_basisG(3,3);

angles = [0; pi/2; 0];
Q = -200;
Br = IR_basisG(3,3);

omegab0_basisb = [0.1; -0.2; 0.5];

H_basisb = I_basisb*omegab0_basisb;
% oRb = rot3(3,angles(1))*rot3(1,angles(2))*rot3(3,angles(3));
% 
% H_basis0 = oRb * H_basisb;

y0 = [angles(1) angles(2) angles(3) omegab0_basisb(1) omegab0_basisb(2) omegab0_basisb(3)];
timespan1 = linspace(0,5,50);
[t1,Y1] = ode45(@(t,y) derattitude_wheels(t,y,Ix,Iy,Iz,Br,Q,OmegaR),timespan1,y0);

y0_2 = Y1(50,:);
timespan2 = linspace(5,40,500);
[t2,Y2] = ode45(@(t,y) derattitude_wheels(t,y,Ix,Iy,Iz,Br,Q,OmegaR),timespan2,y0_2);

figure
hold on
grid minor
plot(t1,Y1(:,1),t2,Y2(:,1))
plot(t1,Y1(:,2),t2,Y2(:,2))
plot(t1,Y1(:,3),t2,Y2(:,3))
hold off