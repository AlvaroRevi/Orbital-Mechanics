function dX_dt = Cowell(X,flag)
% Returns the derivative of the state vector [r,v] with respect to time 
% given the current state of the spacecraft. The function incorporates the
% main acceleration due to Mars and the perturbation acceleration due to
% drag (just in case flag == true) 
%       Inputs: 
%           X: state vector [r,v] 
%          flag: true if we wan to consider perturbation acceleration 
%       
%       Outputs: 
%           dX_dt: derivative of the state vector 

% Global parameters 
    mu = 0.428284e5;                % Gravitational parameter in Mars [km^3/s^2]
    m = 3000;                       % Mass of the spacecraft [kg]
    S = 10;                         % Shield area [m^2]
    CD = 1.5;                       % Drag coefficient
    BC = m/(CD*S);                  % Ballistic coefficient [kg/m^2]
    R_M = 3389.5;                  % Radius of mars [km]

% Derivative of the state vector    
    dX_dt = zeros(6,1); 
    dX_dt(1) = X(4); 
    dX_dt(2) = X(5); 
    dX_dt(3) = X(6);
    dX_dt(4) = -mu*X(1)/(norm(X(1:3))^3);
    dX_dt(5) = -mu*X(2)/(norm(X(1:3))^3);
    dX_dt(6) = -mu*X(3)/(norm(X(1:3))^3);
 
% Compute the acceleration due to the atmospheric drag (just in case that
% the flag is enabled)
    if flag == true 
        a_p = drag_acceleration(Mars_atmosphere(norm(X(1:3))-R_M),BC,X(4:end));
        dX_dt(4) = dX_dt(4) - a_p(1);
        dX_dt(5) = dX_dt(5) - a_p(2);
        dX_dt(6) = dX_dt(6) - a_p(3);
    end 
end 
