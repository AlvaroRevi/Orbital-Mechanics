function Dt = tof(mu,a,e,theta1,theta2)
% Obtain the time of flight between theta1 and theta2 following an elliptic
% trajectory given the rest of COE. 
%
% Inputs: 
%    mu: gravitational parameter [km^3/s^2]
%    a: semi-major axis of the ellipse [km]
%    e: eccentricity
%    theta1: true anomaly in position 1 
%    theta2: true anomaly in position 2
%
% Output: 
%    Dt: time of flight [s]    
    
% Compute the eccentric anomaly for each true anomaly
    E_1 = True2Ecc(theta1,e); 
    E_2 = True2Ecc(theta2,e);

% Compute the mean anomaly for each true anomaly 
    M_e1 = E_1 - e*sin(E_1); 
    M_e2 = E_2 - e*sin(E_2); 

% Compute the mean angular rate 
    n = sqrt(mu/(a^3)); 

% Compute the time of flight 
    Dot = (M_e2 - M_e1)/n; 

end



