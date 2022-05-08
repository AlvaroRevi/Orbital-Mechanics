function theta = Ecc2True(E,e)
% Obtain the true anomaly of a elliptic orbit with E and e as inputs 
%
% Inputs: 
%     E: eccentric anomaly (rads) 
%     e: eccentricity 
%
% Output: 
%     theta: true anomaly

    y = ((1-e.^2).^(1/2).*sin(E))./(1-e.*cos(E)); %sin
    x = (cos(E)-e)./(1-e.*cos(E)); %cos
    
    theta = atan2(y,x);
end