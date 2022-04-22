function H = Mean2EccH(M_h,e)
% Obtain the eccentric anomaly of a hyperbollic orbit with Mh (mean anomaly) 
% and e as inputs. It must be solved by using Newton-Rhapson method. 
%
% Inputs: 
%     Mh: mean anomaly 
%     e: eccentricity 
%
% Output: 
%    H: eccentric anomaly (rads) 

    f = @(H) M_h+H-e*sinh(H);
    df = @(H) 1-e*cosh(H);
    
    x0 = M_h;
    tol = 1e-8;
    maxiter = 1000;
    
    H = newton(f,df,x0,tol,maxiter);
end