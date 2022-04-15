function [a,e,Omega,i,omega,theta1,theta2] = Lambert_solve(mu,r1,r2,Dt,k)
 tol = 1e-2;
 maxiter = 100000; 
% Introduce the chord vector 
    c = r2 - r1; 

% Eccentricity along the chord direction 
    eF = -(norm(r2)-norm(r1))/norm(c);

% Define the limits in order to restrict the search to elliptic orbits
    eT_max = sqrt(1-eF^2); 
    eT_min = -sqrt(1-eF^2); 

% First iteration 
iter = 1;
eT1 = eT_min;
eT2 = eT_max;
eT = (eT_max + eT_min)/2; 
[a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
Dt_iter = tof(mu,a,e,theta1,theta2);


while (abs(Dt-Dt_iter) > tol) && (iter < maxiter)
    if Dt_iter-Dt < 0
        eT_max = eT; 
        eT = (eT_max + eT_min)/2; 
        [a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
        Dt_iter = tof(mu,a,e,theta1,theta2); 
    else 
        eT_min = eT; 
        eT = (eT_max + eT_min)/2; 
        [a,e,Omega,i,omega,theta1,theta2] = Lambert_conic(r1,r2,eT,k);
        Dt_iter = tof(mu,a,e,theta1,theta2); 
    end
    if (tof(mu,a,eT_min,theta1,theta2)-Dt>0 && tof(mu,a,eT_max,theta1,theta2)-Dt>0) || (tof(mu,a,eT_min,theta1,theta2)-Dt<0 && tof(mu,a,eT_max,theta1,theta2)-Dt<0)
        disp('Cuidao')
    end
    disp(Dt_iter-Dt)
    disp(eT_min)
    disp(eT_max)
    iter = iter +1; 
end
disp(iter)