clc;
clear;
close all


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

% Precession of ascending node in an orbit
% deltaOmega = -3*pi*J2*(R_E/p)^3 *cos(i)


% Matching with Earth mean angular rate
% deltaOmega/t = h_E = 360º/365days approx 1º/day
% deltaOmega = 0.0703º

% p = a = ((T/2*pi)^2 *mu_E)^(1/3) = 7259.8 km

% From first Eq. get cos(i) --> i = 98.98º
i = 98.98;

% Run with:
a_0 = 7259.8; % km
e_0 = 0.01;
inc_0 = deg2rad(i); %deg
Omega_0 = deg2rad(0); %deg
omega_0 = deg2rad(50); %deg
theta_0 = deg2rad(100); %deg

% Propagation of trajectory 
T0 = 2*pi*sqrt(a_0^3/muE); 
t_span = [0 30*24*3600]; 
COE_0 = [a_0;e_0;inc_0;Omega_0;omega_0;theta_0]; 

tol = [10^-1 10^-2 10^-3 10^-4 10^-5 10^-6];
options = odeset('RelTol',tol(3));

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
    plot(t/(24*3600),(coe(:,3))-inc_0/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$i-i_{0}$ ','Interpreter','latex')

    subplot(2,3,4)
    plot(t/(24*3600),rad2deg(coe(:,4))/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$RAAN$ ','Interpreter','latex')

    subplot(2,3,5)
    plot(t/(24*3600),(coe(:,5)-omega_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\omega- \omega_{0}$ ','Interpreter','latex')
    
    subplot(2,3,6)
    plot(t/(24*3600),(coe(:,6)-theta_0)/1000)
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\theta -\theta_{0}$ ','Interpreter','latex')





