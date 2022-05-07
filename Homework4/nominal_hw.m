function omega_b0 = nominal_hw(mu,a,e,w,nu) 
% Compute the nominal angular velocity vector omega_b0 to keep the Nadir 
% orientation in the orbit defined by mu, a,e and w as a function of the
% true anomaly 
%      Inputs: 
%           mu: Gravitational constant 
%           a: Semi-major axis 
%           e: Eccentricity 
%           w: Unit vector along h 
%           nu: true anomaly 
%      Outputs: 
%           omega_b0: angular velocity vector 
% 

% Compute the orbit parameter
    p = a*(1-e^2); 

% Compute the angular momentum magnitude and vector 
    h = sqrt(p*mu); 
    h_vec = h*w; 

% Compute the angular rate at that instant 
    r = p/(1+e*cos(nu)); 

    theta_dot = h/(r^2); 

% Compute the angular velocity vector 
    omega_b0 = theta_dot*w; 
end 