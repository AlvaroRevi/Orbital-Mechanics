clc;
clear;
close all

chi_p0 = 150e3; % m
i0 = 30;        % deg
w0 = 50;        % deg    
omega0 = 45;    % deg
theta0 = 100;   % deg
e0 = 0.2;       % deg

muE = 1327120e5;
uS = [1 0 0];   % vector direction in spring
mSC = 10;       % kg
A = ;
CD = 0.5;
Bc = mSC/(S*CD);
flag_srp = 1;
flag_J2 = 0;
flag_drag = 0;

v0 = [state0(4) state0(5) state(6)];

%% Propagation of trajectory
T0 = 2*pi*sqrt(a0^3/muE);
tspan = linspace(0,50*T0,500);
y0 = [r0,v0];

% Tolerance
for i=1:6
    tol = [10^-1 10^-2 10^-3 10^-4 10^-5 10^-6];
    options = odeset('RelTol',tol(i));
    [t,y] = ode45(@(t,y) derECI(t,y,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),tspan,y0);
    coe = sat2coe(y(end,:),muE);
    err(i) = abs((coe(1)-a0)/a0);
end

for i=1:length(y)

end

% COEs
fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
    'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]);
ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica');
box(ax,'on')
grid(ax,'off')
hold(ax,'on')

xlabel('$t$ [days]','Interpreter','latex')
ylabel('$a$ [km]','Interpreter','latex')

plot(t/(24*3600),coe(:,1)/1000,'k')