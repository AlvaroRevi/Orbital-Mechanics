function X = coe2stat(coe,mu)
% Get the state vector in the form [r,v] introducing the Classical Orbital Elements
% and the gravitational constant as inputs. 
%         Inputs: 
%             coe: vector with the 6 different COEs in the following order
%                 a: semimajor axis 
%                 e: eccentricity 
%                 i: inclination angle 
%                 Omega: RAAN 
%                 omega: argument of perigee 
%                 theta: true anomaly
% 
%            mu: Gravitational constant
%         
%         Outputs: 
%             X: state vector in the form [r,v]


% Unpack orbital elements %%%
   a = coe(1);
   e = coe(2);
   i = coe(3);
   Omega = coe(4);
   omega = coe(5);
   theta = coe(6);
   
   p = a*(1-e^2);  % p = semi-latus rectum (semiparameter)
   
% Position Coordinates in Perifocal Coordinate System
   
   r_PQW(1) = p*cos(theta) / (1+e*cos(theta)); % x-coordinate (km)
   r_PQW(2) = p*sin(theta) / (1+e*cos(theta)); % y-coordinate (km)
   r_PQW(3) = 0;                             % z-coordinate (km)
   v_PQW(1) = -sqrt(mu/p) * sin(theta);       % velocity in x (km/s)
   v_PQW(2) =  sqrt(mu/p) * (e+cos(theta));   % velocity in y (km/s)
   v_PQW(3) =  0;                            % velocity in z (km/s)
   
 % Compute rotation matrix (3 Rotations)  %%%
   R = rot3(3,-Omega)*rot3(1,-i)*rot3(3,-omega);
   
 % Transforming Perifocal -> xyz  %%%
   r = R*r_PQW';
   v = R*v_PQW';

 % Pack the 
   X = vertcat(r,v); 
end