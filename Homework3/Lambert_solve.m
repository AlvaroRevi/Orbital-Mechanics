function [a,e,Omega,i,omega,theta1,theta2] = Lambert_solve(mu,r1,r2,Dt,k)
% Solve Lambert problem by means of a bisection method. The function takes
% as inputs two given position vectors and the time of flight between both 
% and returns the COEs of the orbit as well as the true anomalies
% corresponding to both position vectors. 
% Note that the search must be restricted to elliptic solutions  
%        Inputs: 
%             mu: gravitational parameter [km
%             r1: position vector 1 
%             r2: position vector 2 
%             Dt: time of flight required
%             k: unit vector in the direction normal to the orbital plane 
%         Outputs: 
%             a: semi-major axis 
%             e: eccentricity 
%             Omega: RAAN  
%             i: inclination angle 
%             omega: argument of periapsis 
%             theta1: true anomaly corresponding to r1 
%             theta2: true anomaly corresponding to r2 


% Define the tolerance and the maximum number of iterations  
 tol = 1;
 maxiter = 1000; 
% Introduce the chord vector 
    c = r2 - r1; 

% Eccentricity along the chord direction 
    eF = -(norm(r2)-norm(r1))/norm(c);

% Define the limits in order to restrict the search to elliptic orbits
    eT_max = 0.99*sqrt(1-eF^2); 
    eT_min = -0.99*sqrt(1-eF^2); 

% First iteration 
iter = 1; 
eT = (eT_max + eT_min)/2; 
[a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
Dt_iter = tof(mu,a,e,theta1,theta2);

% Apply bisection method until the time of flight of the lambert conic
% matches the required time of flight 

while (abs(Dt-Dt_iter) > tol) && (iter< maxiter)
    if Dt < Dt_iter
        eT_max = eT; 
        eT_min = eT_min; 
        eT = (eT_max + eT_min)/2; 
        [a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
        Dt_iter = tof(mu,a,e,theta1,theta2); 
    else 
        eT_max = eT_max; 
        eT_min = eT; 
        eT = (eT_max + eT_min)/2; 
        [a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
        Dt_iter = tof(mu,a,e,theta1,theta2); 
    end
    iter = iter +1; 
end
% disp(iter)
end