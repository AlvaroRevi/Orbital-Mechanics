function [a,e,Omega,i,omega,theta1,theta2] = Lambert_solve(mu,r1,r2,Dt,k)
 tol = 1e-2;
 maxiter = 100000; 
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