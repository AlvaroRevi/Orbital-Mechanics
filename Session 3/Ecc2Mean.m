function Me = Ecc2Mean(E, e)
% Obtain the mean anomaly of a elliptic orbit with E and e as inputs 
%
% Inputs: 
%     E: eccentric anomaly (rads) 
%     e: eccentricity 
%
% Output: 
%     Me: mean anomaly
  if e > 1 
      error('e must be < 1 in an ellipse')
  end

  Me = E-e*sin(E);
end