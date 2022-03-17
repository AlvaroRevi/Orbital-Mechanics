function acc_p=drag_acc_COE(COE,B_c)

%   INPUTS
%   COE = [a, (semi major axis)
%          e, (eccentricity)
%          i, (inclination)
%          node, (right ascension of ascending node)
%          arg, (argument of perigee)
%          true (true anomaly) ]
    
    mu_E = 1327120e5; % km3/s2
    R_earth = 6371; %km
    g = 9.80665;
    a = COE(1);
    e = COE(2);
    inc = COE(3);
    Omega = COE(4);
    omega = COE(5);
    theta = COE(6);

    h = sqrt(mu_E*a*(1-e^2));
    
    r_SC = a*(1-e^2)/(1+e*cos(theta));
    v_SC = mu_E/h *[e*sin(theta);1+e*cos(theta);0];
    
    % Reference values at 86km altitude 
    chi_ref = 86e3;                     % Reference altitude [m]
    T_ref = -86.28 + 273.15;            % Reference temperature [K]
    R = 8.314;                          % Gas constant [J/K mol]
    M = 29e-3;                          % Molar mass [kg/mol]
    P_ref = 0.3734;                     % Reference pressure [Pa]
    rho_ref = P_ref*M/(R*T_ref);        % Reference density [kg/m^3]
    
    % Compute the scale-height parameter 
    H = R*T_ref/(g*M); 
    
    % Exponential evolution of pressure with height 
    chi = norm(r_SC) - R_earth; 
    rho = rho_ref*exp(-(chi- chi_ref)/H);
    
    % Compute the acceleration due to atmospheric drag
    acc_p = -1/(2*B_c)*rho*norm(v_SC)*v_SC;       %[m/s^2]
end
