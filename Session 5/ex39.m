clear; clc; close all; 

% Input 
R_e = 6371e3; 
muE = 3.986e14; 
uS = [1;0;0]; % Assume 21st March 
A = pi*1^2; 
mSC = 10; 
CD = 0.5; 
Bc = (mSC*10^-3)/(CD*A); 

flag_srp = false; 
flag_J2 = true; 
flag_drag = false; 

% Initial orbital elements of the spacecraft 
a_0 = R_e + 150e3;                 % 
i_0 = deg2rad(30);                 %
i_0 = 1.7275;    
omega_0 = deg2rad(50); 
e_0 = 0.2; 
Omega_0 = deg2rad(45); 
theta_0 = deg2rad(100); 

% st_vector = coe2stat([a_0,e_0,i_0,omega_0, w_0, theta_0],muE); 
% r0 = [st_vector(1:3)]; 
% v0 = [st_vector(4:6)]; 

% Propagation of trajectory 
T0 = 2*pi*sqrt(a_0^3/muE); 
t_span = [0 24*365*3600]; 
COE_0 = [a_0;e_0;i_0;Omega_0;omega_0;theta_0]; 

tol = [10^-1 10^-2 10^-3 10^-4 10^-5 10^-6];
options = odeset('RelTol',tol(1));

[t,coe] = ode45(@(t,COE) derECI_COE(t,COE,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,COE_0,options); 

%% Figures

figure(1)
    subplot(2,3,1)
    plot(t/(24*3600),(coe(:,1)-a_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$a-a_{0}$ [km]','Interpreter','latex')

    subplot(2,3,2)
    plot(t/(24*3600),(coe(:,2)-e_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$e-e_{0}$','Interpreter','latex')
    
    subplot(2,3,3)
    plot(t/(24*3600),(coe(:,3))-i_0/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$i-i_{0}$ ','Interpreter','latex')

    subplot(2,3,4)
    plot(t/(24*3600),(rad2deg(coe(:,4)-Omega_0))/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$RAAN - RAAN_{0}$ ','Interpreter','latex')

    subplot(2,3,5)
    plot(t/(24*3600),(coe(:,5)-omega_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\omega- \omega_{0}$ ','Interpreter','latex')
    
    subplot(2,3,6)
    plot(t/(24*3600),(coe(:,6)-theta_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\theta -\theta_{0}$ ','Interpreter','latex')


