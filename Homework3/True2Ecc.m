function E = True2Ecc(theta, e)
% Obtain the eccentric anomaly of a elliptic orbit with true anomaly 
% and e as inputs. 
%
% Inputs: 
%    theta: true anomaly 
%    e: eccentricity 
%
% Output: 
%    E: eccentric anomaly (rads)

    y = ((1-e.^2).^(1/2).*sin(theta))./(1+e.*cos(theta)); %sin
    x = (e+cos(theta))./(1+e.*cos(theta)); %cos
    
    E = atan2(y,x);
end