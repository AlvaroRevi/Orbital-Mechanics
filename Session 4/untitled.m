clear; clc; close all; clear all; 
% Input 
R_e = 6371e3; 
muE = 3.986e14; 
uS = [1;0;0]; % Assume 21st March 
A = pi*1^2; 
mSC = 10; 
CD = 0.5; 
Bc = (mSC*10^-3)/(CD*A); 

flag_srp = false; 
flag_J2 = false; 
flag_drag = false; 

% Initial orbital elements of the spacecraft 
a_0 = R_e + 150e3;                 % 
i_0 = deg2rad(30);                 %
w_0 = deg2rad(50); 
e_0 = 0.2; 
omega_0 = deg2rad(45); 
theta_0 = deg2rad(100); 

st_vector = coe2stat([a_0,e_0,i_0,omega_0, w_0, theta_0],muE); 
r0 = [st_vector(1:3)]; 
v0 = [st_vector(4:6)]; 

% Propagation of trajectory 
T0 = 2*pi*sqrt(a_0^3/muE); 
t_span = [0 50*T0]; 
y0 = [r0;v0]; 


[t,y] = ode45(@(t,y) derECI(t,y,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,y0); 




for j = 1:length(y) 
    coe(j,:) = stat2coe(y(j,:),muE); 
end

figure(1)
    subplot(2,3,1)
    plot(t/(24*3600),coe(:,1)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$a$ [km]','Interpreter','latex')

    subplot(2,3,2)
    plot(t/(24*3600),coe(:,2))
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$e$','Interpreter','latex')
    
    subplot(2,3,3)
    plot(t/(24*3600),coe(:,3))
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$i$ ','Interpreter','latex')

    subplot(2,3,4)
    plot(t/(24*3600),coe(:,4))
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$RAAN$ ','Interpreter','latex')

    subplot(2,3,5)
    plot(t/(24*3600),coe(:,5))
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\omega$ ','Interpreter','latex')
    
    subplot(2,3,6)
    plot(t/(24*3600),coe(:,6))
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\omega$ ','Interpreter','latex')

