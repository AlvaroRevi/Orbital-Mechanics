function acc = drag_acc(r_SC,v_SC,B_c)
%     Determine the perturbing acceleration due to drag on a spacecraft given 
%     its Bc, its position and its velocity. Assume an isothermal atmosphere 
%     with T = -86.28oC, M = 29 kg/kmol and 0.3734 Pa at chi = 86 km
%     
%     NOTE: ALL VARIABLES ARE IN INTERNATIONAL SYSTEM (length in meters)
%
%             Input: 
%                 r_SC: Position in ECI [m]
%                 v_sc: Velocity in ECI [m/s]
%                 B_c: Ballistic coefficient
%             Output:
%                 acc: Perturbing acceleration due to atmospheric drag
    % Parameters 
    R_earth = 6371*10^3; 
    g = 9.80665;                        % Gravity [m/s^2]
    
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
    rho = rho_ref*exp(-(chi_ref- chi)/H);
    
    % Compute the acceleration due to atmospheric drag
    acc = -1/(2*B_c)*rho*norm(v_SC)*v_SC;       %[m/s^2]
end
    
    
    
    