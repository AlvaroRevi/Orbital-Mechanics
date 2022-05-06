function rho = Mars_atmosphere(zeta) 
% Returns the air density at a given height 
%       Input: 
%           zeta: height over Mars surface [km]
%       Output: 
%           rho: density [kg/m^3]

% Reference values 
    T = 128;                        % Temperature [K]
    R = 8.314;                      % Gas constant [J/K mol]
    M = 43.4/1000;                  % Molar mass [kg/mol] 
    zeta_ref = 120;                 % Reference height [km]
    p_ref = 3.38e-4;                % Pressure at zeta_ref (120km) [Pa]
    g = 3.72;                       % Gravity [m/s^2]

% Scale-height parameter 
    H = R*T/(g*M);

% Compute the density at the reference altitude 
    rho_ref = p_ref*M/(R*T); 

% Compute the evolution of density as a function of height (zeta) 
    rho = rho_ref*exp((zeta_ref-zeta)*1000/H); 
end 