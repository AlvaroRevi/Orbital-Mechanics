function Me = Ecc2Mean(E, e)
% Obtain the mean anomaly of a elliptic orbit with E and e as inputs 
%
% Inputs: 
%     E: eccentric anomaly (rads) 
%     e: eccentricity 
%
% Output: 
%     Me: mean anomaly
    Me = E-e*sin(E);
end