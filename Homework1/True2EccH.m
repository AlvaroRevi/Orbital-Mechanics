function H = True2EccH(theta, e)
% Obtain the eccentric anomaly of a hyperbolic orbit with true anomaly 
% and e as inputs. 
%
% Inputs: 
%    theta: true anomaly 
%    e: eccentricity 
%
% Output: 
%    E: eccentric anomaly (rads)

    y = ((e.^2-1).^(1/2).*sin(theta))./(1+e.*cos(theta)); %sinh
    x = (e+cos(theta))./(1+e.*cos(theta)); %cosh
    
    H = atanh(y/x);
end