clear; clc; close all 
I_V_basisb = diag([4000,7500,8500]);
I_R_basisb = diag([50,50,100]); 

omega_V_0 = [0;0;0]; 

%% t < 5s

Q = -200; 
Br = 100; 

Ix = I_V_basisb(1,1)+ I_R_basisb(1,1); 
Iy = I_V_basisb(2,2)+ I_R_basisb(2,2); 
Iz = I_V_basisb(3,3)+ I_R_basisb(3,3); 
y0 = [0;pi/2;0;0;0;0]; 

[t1,Y1] = ode45(@(t,X) derattitude(t,X,Ix,Iy,Iz,Q,Br), linspace(0,5,1000), y0); 

%% t > 5 

Q = 0; 
Br = 100; 

Ix = I_V_basisb(1,1)+ I_R_basisb(1,1); 
Iy = I_V_basisb(2,2)+ I_R_basisb(2,2); 
Iz = I_V_basisb(3,3)+ I_R_basisb(3,3); 
y0 = Y1(end,:); 

[t2,Y2] = ode45(@(t,X) derattitude(t,X,Ix,Iy,Iz,Q,Br), linspace(5,40,1000), y0); 


figure(1)
hold on 
plot([t1 t2],[Y1(:,1) Y2(:,1)])
plot([t1 t2],[Y1(:,2) Y2(:,2)])
plot([t1 t2],[Y1(:,3) Y2(:,3)])

figure(2)
hold on 
plot(t1,Y1(:,4))
plot(t1,Y1(:,5))
plot(t1,Y1(:,6))


