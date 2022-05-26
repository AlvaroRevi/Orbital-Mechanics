clear; clc; close all; clear all; 
%% Initialization 
    % Parameters 
    R_e = 6371e3;                            % Earth radius [m]
    muE = 3.986e14;                          % Gravity constant []
    uS = [1;0;0];                            % Sun vector (Assume 21st March) 
    A = pi*1^2;                              % Area  of the spacecraft [m^2]
    mSC = 10;                                % Mass of spacecraft [kg]
    CD = 0.5;                                % Drag coefficient 
    Bc = (mSC*10^-3)/(CD*A);                 % Ballistic coefficient 
    
    flag_srp = true;                        % Sun radiation force flag 
    flag_J2 = false;                         % J2 acceleration flag
    flag_drag = false;                       % Drag acceleration flag
    
    % Initial classical orbital elements of the spacecraft 
    a_0 = R_e + 150e3;                       % Semimajor axis [m]
    i_0 = deg2rad(30);                       % Inclination angle [rad]
    w_0 = deg2rad(50);                       % Argument of perigee [rad]
    e_0 = 0.2;                               % Eccentricity [-]
    omega_0 = deg2rad(45);                   % RAAN [rad]
    theta_0 = deg2rad(100);                  % True anomaly [rad]
    
    % Compute the initial state vector from the initial COEs
    st_vector = coe2stat([a_0,e_0,i_0,omega_0, w_0, theta_0],muE); 
    r0 = [st_vector(1:3)]; 
    v0 = [st_vector(4:6)]; 
    
    % Propagation of trajectory 
    T0 = 2*pi*sqrt(a_0^3/muE);              % Period of the trajectory [s]
    %t_span = [0 50*T0];                     % Time span (50 periods)
    t_span = linspace(0,50*T0,10000);
    y0 = [r0;v0];                           % Initial state vector in columns

%% Tolerance 
    % for i = 1:6 
    %     tol = [1e-1 1e-2 1e-3 1e-4 1e-5 1e-6]; 
    %     options = odeset('RelTol',tol(i));
    %     [t,y] = ode45(@(t,y) derECI(t,y,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,y0,options);
    %     coe = stat2coe(y(end,:),muE);
    %     err(i) = abs((coe(1)-a_0)/a_0); 
    % end
    % fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
    %     'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    % ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    % box(ax,'on')
    % grid(ax,'off') 
    % hold(ax,'on') 
    % set(gca, 'XScale','log')
    % set(gca, 'YScale','log') 
    % 
    % xlabel('$tol$', 'Interpreter', 'latex')
    % ylabel('$\varepsilon$ ', 'Interpreter','latex') 
    % 
    % plot(tol,err,'k')


%% ODE 
    % Apply ode45 to calculate the evolution in time of the state vector 
    [t,y] = ode45(@(t,y) derECI(t,y,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag),t_span,y0); 
    
    % Retrieve the evolution in time of the COEs from the state vector
    for j = 1:length(y) 
        coe(j,:) = stat2coe(y(j,:),muE); 
    end

%% Plots all-in-one 
    % figure(1)
    %     subplot(2,3,1)
    %     plot(t/(24*3600),coe(:,1)/1000,'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$a$ [km]','Interpreter','latex')
    % 
    %     subplot(2,3,2)
    %     plot(t/(24*3600),coe(:,2),'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$e$','Interpreter','latex')
    %     
    %     subplot(2,3,3)
    %     plot(t/(24*3600),coe(:,3),'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$i$ ','Interpreter','latex')
    % 
    %     subplot(2,3,4)
    %     plot(t/(24*3600),coe(:,4),'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$RAAN$ ','Interpreter','latex')
    % 
    %     subplot(2,3,5)
    %     plot(t/(24*3600),coe(:,5),'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$\omega$ ','Interpreter','latex')
    %     
    %     subplot(2,3,6)
    %     plot(t/(24*3600),coe(:,6),'k')
    %     xlabel('$t$ [days]','Interpreter','latex')
    %     ylabel('$\omega$ ','Interpreter','latex')


%% Plots separated
    % Evolution of semimajor axis in time 
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$a$ [km]', 'Interpreter','latex') 
    
    plot(t/(24*3600),coe(:,1)/1000,'k') 
    
    % Evolution of eccentricity in time
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$e$ ', 'Interpreter','latex') 
    
    plot(t/(24*3600),coe(:,2),'k')
    
    % Evolution of inclination angle in time
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$i$ ', 'Interpreter','latex') 
    
    plot(t/(24*3600),rad2deg(coe(:,3)),'k')
    
    % Evolution of RAAN in time
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$RAAN$ ', 'Interpreter','latex') 
    
    plot(t/(24*3600),rad2deg(coe(:,4)),'k')
    
    % Evolution of argument of perigee in time
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$\omega$ ', 'Interpreter','latex') 
    
    plot(t/(24*3600),rad2deg(coe(:,5)),'k')
    
    % Evolution of true anomaly in time
    fig = figure('PaperUnits','inches','PaperPositionMode','auto','PaperType','<custom>',...
        'PaperSize',[1.2*6.5 1.2*4.875],'Color',[1 1 1]); 
    ax = axes('Parent',fig,'FontSize',26,'FontName','Helvetica'); 
    box(ax,'on')
    grid(ax,'off') 
    hold(ax,'on') 
    
    xlabel('$t$ [days]', 'Interpreter', 'latex')
    ylabel('$\theta$ ', 'Interpreter','latex') 
    
    plot(t/(24*3600),rad2deg(coe(:,6)),'k')