function [a,e,Omega,i_c,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k)
% Enrique Sentana and Alvaro Reviriego 
% Compute the COE of the transfer trajectory between position vectors r1 
% and r2, as a function of the transverse eccentricity component, eT . 
% Vector k defines the positive direction of the orbital plane normal and 
% therefore selects between short and long arc solutions
% 
% Implementation of the algorithm developes in Avanzini 2008. 
% All vectors given in ICRF 
%
% Inputs: 
%    r1: position vector 1
%    r2: position vector 2
%    eT: transverse eccentricity component
%    k: vector defining the direction of the orbital plane normal
%
% Output: 
%    a: semi-major axis 
%    e: eccentricity 
%    i: inclination angle
%    Omega: RAAN 
%    omega: argument of perigee 
%    theta1: true anomaly of point 1 
%    theta2: true anomaly of point 2

% Check if we want to perform the long or the short arc
    k_vec = cross(r1,r2)/norm(cross(r1,r2)); 
    
    if k_vec == k 
        % Short arc 
        Dtheta = acos(dot(r1,r2)/(norm(r1)*norm(r2))); 
    elseif k_vec == -k 
        % Long arc 
        Dtheta = acos(dot(r1,r2)/(norm(r1)*norm(r2))) -2*pi; 
    else 
        error('k does not coincide with the expected vector')
    end
 

% Introduce the chord vector 
    c = r2 - r1; 

% Define the chord vector basis i,j,k (note that k is an input)
    i_c = c/norm(c); 
    k_c = k; 
    j_c = cross(k_c,i_c); 
    
% Eccentricity along the chord direction 
    eF = -(norm(r2)-norm(r1))/norm(c); 

% Eccentricity vector 
    e_vec = eF*i_c + eT*j_c; 

% Parameters of the fundamental ellipse 
    aF = (norm(r1) + norm(r2))/2; 
    pF = aF*(1- eF^2); 

% Shape of the conic 
    p = pF - eT*norm(r1)*norm(r2)*sin(Dtheta)/norm(c); 
    e = norm(e_vec); 
    a = p/(1 - e^2); 

% Once a and e are defined, we can compute the periphocal reference frame
    i_p = e_vec/e; 
    k_p = k_c; 
    j_p = cross(k_p,i_p); 

% Compute the inclination angle 
    i = acos(dot(k_p,[0,0,1]));

% Compute the RAAN 
    n = cross([1,0,0],k_c)/norm(cross([1,0,0],k_c)); 
    Omega = atan2(dot(n,[1,0,0]),dot(n,[0,1,0])); 

% Compute the argument of perigee 
    m = cross(k_c,n); 
    omega = atan2(dot(i_p,n),dot(i_p,m)); 

% Compute the true anomalies
    theta1 = acos(dot(i_p,r1)/norm(r1)); 
    theta2 = acos(dot(i_p,r2)/norm(r2)); 
end
    
    


