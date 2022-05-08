clc;
clear;
close all

% Sun data
muS = 1327120e5;

% Venus low orbit data
muV = 3.24859e5;        % [km3/s2] 
aV = 10000;             % [km]
eV = 0;
OmegaV = deg2rad(30);   % [rad]
omegaV = deg2rad(56);   % [rad] from JPL Horizons
iV = deg2rad(15);       % [rad] 

% Mercury low orbit data
muM = 0.220318e5;       % [km3/s2]
aM = 5000;              % [km]
eM = 0;
OmegaM = deg2rad(50);   % [rad]
omegaM = deg2rad(30.02);% [rad] from JPL Horizons 
iM = deg2rad(-40);      % [rad]

%% Exercise c
% Create departure dates, distrubute the days for 2312
% (which is a leap-year)
days = linspace(1,366,366);

% Create different travel time options
travel_times = linspace(60,90,31);

% Create meshgrid
[DAYS,TRAVEL_TIMES] = meshgrid(days, travel_times);

% COEs of Mercury and Venus from JPL Horizons database wrt ICRF in t0
a_V = 1.082e8;
e_V = 6.648e-3; 
i_V = deg2rad(3.392);
Omega_V = deg2rad(75.811);
omega_V = deg2rad(56);   % [rad]
theta_V = deg2rad(101.076);
X_V(:,1) = coe2stat([a_V,e_V,i_V,Omega_V,omega_V,theta_V],muS);


E_V_init = True2Ecc(theta_V,e_V); 
Me_V_init = Ecc2Mean(E_V_init,e_V);
ne_V = sqrt(muS/(a_V^3));

a_M = 5.7909e7; 
e_M = 0.2056;
Omega_M = deg2rad(47.938);
i_M = deg2rad(6.986);
omega_M = deg2rad(30.015);% [rad] from JPL Horizons 
theta_M = deg2rad(294.732); 
X_M(:,1) = coe2stat([a_M,e_M,i_M,Omega_M,omega_M,theta_M],muS);


E_M_init = True2Ecc(theta_M,e_M); 
Me_M_init = Ecc2Mean(E_M_init,e_M);
ne_M = sqrt(muS/(a_M^3));

for j=2:366
    % Propagate the orbit of Venus for each day 
    Me_V_new = Me_V_init + ne_V*(days(j)-days(1))*24*3600;
    E_V_new = Mean2Ecc(Me_V_new,e_V); 
    theta_V_new = Ecc2True(E_V_new,e_V);
    X_V(:,j) = coe2stat([a_V,e_V,i_V,Omega_V,omega_V,theta_V_new],muS);
    
    % Propagate the orbit of Venus for each day 
    Me_M_new = Me_M_init + ne_M*(days(j)-days(1))*24*3600;
    E_M_new = Mean2Ecc(Me_M_new,e_M); 
    theta_M_new = Ecc2True(E_M_new,e_M);
    X_M(:,j) = coe2stat([a_M,e_M,i_M,Omega_M,omega_M,theta_M_new],muS);
end


%% Exercise d

for jj = 1:length(days)
    % Compute the position of Venus at the departure time 
    Me_V_new = Me_V_init + ne_V*(days(jj)-days(1))*24*3600;
    E_V_new = Mean2Ecc(Me_V_new,e_V); 
    theta_V_new = Ecc2True(E_V_new,e_V);
    X_V_departure(:,jj) = coe2stat([a_V,e_V,i_V,Omega_V,omega_V,theta_V_new],muS);
    
    
    for kk = 1:length(travel_times)
        % Compute the position of Mercury at arrival time
        Me_M_new = Me_M_init + ne_M*(days(jj)+travel_times(kk)-days(1))*24*3600;
        E_M_new = Mean2Ecc(Me_M_new,e_M); 
        theta_M_new = Ecc2True(E_M_new,e_M);
        X_M_arrival(:,jj,kk) = coe2stat([a_M,e_M,i_M,Omega_M,omega_M,theta_M_new],muS);


        r_V = X_V_departure(1:3,jj);
        r_M = X_M_arrival(1:3,jj,kk);

        % Apply Lambert solver to determine the hyperbolic velocity at
        % departure and arrival 
        k_long = cross(r_M,r_V)/norm(cross(r_M,r_V));
        [a_t_long,e_t_long,Omega_t_long,i_t_long,omega_t_long,theta_V_t_long,theta_M_t_long] = Lambert_solve(muS,r_V,r_M,travel_times(kk),k_long);
        
        X_V_lambert_long = coe2stat([a_t_long,e_t_long,i_t_long,Omega_t_long,omega_t_long,theta_V_t_long],muS); 
        V_h_V_long = X_V_lambert_long(4:6); 
        
        [theta_hyp_V, Dv_V] = hyperbola(muV,aV,eV,OmegaV,iV,omegaV,V_h_V_long);

        X_M_lambert_long = coe2stat([a_t_long,e_t_long,i_t_long,Omega_t_long,omega_t_long,theta_M_t_long],muS);
        V_h_M_long = X_M_lambert_long(4:6);
        
        [theta_hyp_M, Dv_M] = hyperbola(muM,aM,eM,OmegaM,iM,omegaM,V_h_M_long);

        DV(kk,jj) = Dv_V + Dv_M; 
        C3(kk,jj) = Dv_V^2 + Dv_M^2; 

    end

end
 
figure('Renderer', 'painters', 'Position', [20 20 1200 600])
title('Venus to Mercury total $\Delta v$ $[km^{2}/s^{2}]$','Interpreter','latex')
xlabel('Days from January 1 2312','Interpreter','latex')
ylabel('Travel time [days]','Interpreter','latex')
hold on
[C,h]= contour(DAYS,TRAVEL_TIMES,DV,'ShowText','on','LineWidth',1,'LineColor','k')   
clabel(C,h,[80,90,100])
[~, minIdx] = min(DV(:)); 
[row,col] = ind2sub(size(DV),minIdx); 
daysMin = DAYS(row,col); 
ttMin = TRAVEL_TIMES(row,col);
plot(daysMin, ttMin, 'rx')
hold off


figure('Renderer', 'painters', 'Position', [20 20 1200 600])
title('Venus to Mercury total $c_{3}$ $[km^{2}/s^{2}]$','Interpreter','latex')
xlabel('Days from January 1 2312','Interpreter','latex')
ylabel('Travel time [days]','Interpreter','latex')
hold on 
contour(DAYS,TRAVEL_TIMES,C3,'ShowText','on','LineWidth',1,'LineColor','k')
[~, minIdx] = min(DV(:)); 
[row,col] = ind2sub(size(C3),minIdx); 
daysMin = DAYS(row,col); 
ttMin = TRAVEL_TIMES(row,col);
plot(daysMin, ttMin, 'rx')
hold off


%% Plots 

% Find the COEs of the best heliocentric transfer 
r_V = X_V_departure(1:3,84); 
r_M = X_M_arrival(1:3,84);
k_helio = cross(r_V,r_M)/norm(cross(r_V,r_M));
[a_helio,e_helio,Omega_helio,i_helio,omega_helio,thetaV_helio,thetaM_helio] = Lambert_solve(muS,r_V,r_M,60,k_helio);

theta_linspace = linspace(0,2*pi,10000);
for iii = 1:length(theta_linspace)
    X_helio(:,iii) = coe2stat([a_helio,e_helio,i_helio,Omega_helio,omega_helio,theta_linspace(iii)],muS); 
end



close all
figure(3);
hold on 
plot3(0,0,0,'y.','MarkerSize',200)
plot3(X_V(1,:),X_V(2,:),X_V(3,:),'b')
plot3(X_M(1,:),X_M(2,:),X_M(3,:),'r')
for ii = 1:length(X_V)
    pointVenus = plot3(X_V(1,ii),X_V(2,ii),X_V(3,ii),'b.','MarkerSize',20);
    pointMercury = plot3(X_M(1,ii),X_M(2,ii),X_M(3,ii),'r.','MarkerSize',20);
    pause(0.05)
    delete(pointMercury)
    delete(pointVenus)
end
ylim([-5e7,5e7])
xlabel('ECI x [m]');
ylabel('ECI y [m]');
zlabel('ECI z [m]');
title('Satellite Orbit in ECI Coordinates');
grid minor

figure(4)
hold on 
plot3(0,0,0,'y.','MarkerSize',20)
plot3(r_V(1),r_V(2),r_V(3),'b.','MarkerSize',20)
plot3(r_M(1),r_M(2),r_M(3),'r.','MarkerSize',20)
plot3(X_helio(1,:),X_helio(2,:),X_helio(3,:))
grid minor
