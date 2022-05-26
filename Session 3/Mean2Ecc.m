function E = Mean2Ecc(Me,e)
% Obtain the eccentric anomaly of a elliptic orbit with Me (mean anomaly) 
% and e as inputs. It must be solved by using Newton-Rhapson method. 
%
% Inputs: 
%     Me: mean anomaly 
%     e: eccentricity 
%
% Output: 
%    E: eccentric anomaly (rads) 

    f = @(E) Me-E+e*sin(E);
    df = @(E) -1+e*cos(E);
    
    x0 = Me;
    tol = 1e-8;
    maxiter = 1000;
    
    E = newton(f,df,x0,tol,maxiter);
end