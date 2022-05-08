clc;
clear;
close all

% Sun data
muS = 1327120e5;

% Venus data
muV = 3.24859e5;        % [km3/s2] 
aV_planet = 108.21e6;   % [km]
aV = 10000;             % [km]
eV = 0;
OmegaV = deg2rad(30);   % [rad]
omegaV = deg2rad(56);   % [rad]
iV = deg2rad(15);       % [rad] 

% Mercury data
muM = 0.220318e5;       % [km3/s2]
aM_planet = 57.909e6;   % [km]
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

% COE of Mercury and Venus from JPL Horizons database wrt ICRF in t0
omegaV = deg2rad(56);   % [rad]

omegaM = deg2rad(30.02);% [rad] from JPL Horizons 

%% Exercise d
k_long = 1;
k_short = -1;

for j=1:366
    for k =1:31
        % Escape from Venus
        vhV = sqrt(muS/aV_planet)*(sqrt(2*aM_planet/(aV_planet+aM_planet))-1);
        [theta_V,Dv_V] = hyperbola(muV,aV,eV,OmegaV,iV,omegaV,vhV);

        % Arrival to Mercury
        vhM = sqrt(muS/aM_planet)*(1-sqrt(2*aM_planet/(aV_planet+aM_planet)));
        [theta_M,Dv_M] = hyperbola(muM,aM,eM,OmegaM,iM,omegaM,vhM);
        
%         % Short arc
%         [a_transf(j,k),e_transf(j,k),Omega_transf(j,k),i_transf(j,k),omega_transf(j,k),theta1_transf(j,k),theta2_transf(j,k)]...
%             = Lambert_solve(muS,r1,r2,travel_times(k),k_short);
%         
%         % Long arc
%         [a_transf(j,k),e_transf(j,k),Omega_transf(j,k),i_transf(j,k),omega_transf(j,k),theta1_transf(j,k),theta2_transf(j,k)]...
%             = Lambert_solve(muS,r1,r2,travel_times(k),k_long);
        
        % Compute the total impulse required for Venus-Mercury trip
        Dv_tot(j,k) = Dv_V + Dv_M;
    end
end

figure 
hold on
contour(DAYS,TRAVEL_TIMES,Dv_tot')
colorbar
hold off