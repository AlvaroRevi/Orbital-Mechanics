clear; clc; close all; 
% Input 
R_e = 6371e3; 
muE = 3.986e14; 
uS = [1;0;0] % Assume 21st March 
A = pi*1^2; 
mSC = 10; 
CD = 0.5; 
Bc = (mSC*10^-3)/(CD*A); 

flag_srp = false; 
flag_J2 = false; 
flag_drag = false; 

% Initial orbital elements of the spacecraft 
a_0 = R_e + 150e3;                 % 
i_0 = deg2rad(30);              %
w_0 = deg2rad(50); 
e_0 = 0.2; 
omega_0 = deg2rad(45); 
theta_0 = deg2rad(100); 

state0 = coe2stat(a_0,e_0,i_0,omega_0, w_0, theta_0,muE); 
r0 = [state0(1); state(2); state0(3)]; 
v0 = [state0(4); state(5);state0(6)]; 

% Propagation of trajectory 
T0 = 2*pi*sqrt(a_0^3/muE); 
t_span = [0 50*T0]; 
y0 = [r0;v0]; 

% Tolerance 
for i = 1:6 
    tol = [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6]; 
    options = odeset('RelTol',tol(i));
    [t,y] = ode45(@(t,y) derECI(t,y,mu,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,y0,options);
    coe = stat2coe(y(end,:),muE);
    err(i) = abs((coe(1)-a0)/a0); 
end


[t,y] = ode45(@(t,y) derECI(t,y,mu,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,y0); 

for i = 1:length(y) 
    coe(i,:) = stat2coe(y(i,:),muE); 
end

fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
    'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
ax = axes('Parent',fig,,'FontSize',26,'FontName','Helvetica'); 
box(ax,'on')
grid(ax,'off') 
hold(ax,'on') 
set(gca, 'XScale','log')
set(gca, 'YScale','log') 

xlabel('$tol$', 'Interpreter', 'latex')
ylabel('$\varepsilon$ ', 'Interpreter','latex') 

plot(tol,err,'k') 

% COE 

fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
    'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
ax = axes('Parent',fig,,'FontSize',26,'FontName','Helvetica'); 
box(ax,'on')
grid(ax,'off') 
hold(ax,'on') 

xlabel('$t$ [days]', 'Interpreter', 'latex')
ylabel('$a$ [km]', 'Interpreter','latex') 

plot(t/(24*3600),coe(:,1)/1000,'k') 

fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
    'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
ax = axes('Parent',fig,,'FontSize',26,'FontName','Helvetica');
box(ax,'on')
