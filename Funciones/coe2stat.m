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

% Unpack orbital elements 
   a = coe(1);
   e = coe(2);
   i = coe(3);
   Omega = coe(4);
   omega = coe(5);
   theta = coe(6);

% Perform the rotation to the PQR axis (periphocal reference frame)  
  rotation = rot3(3,-omega)*rot3(1,-i)*rot3(3,-Omega); 

  i_PQR = rotation(1,:); 
  j_PQR = rotation(2,:); 
  k_PQR = rotation(3,:); 

 % Compute the orbital parameter, the angular momentum and the radius of the orbit
   r = a*(1-e.^2)./(1+e*cos(theta));
   p = a*(1-e.^2);
   h = sqrt(mu*p);
 

% Compute the position vector 
  r_vec = r*(cos(theta)*i_PQR + sin(theta)*j_PQR); 

% Compute the velocity vector 
  v_vec = (e*mu*sin(theta)/h)*(cos(theta)*i_PQR + sin(theta)*j_PQR) + (h/r)*(-sin(theta)*i_PQR+cos(theta)*j_PQR);

% Return state vector 
  X = vertcat(r_vec',v_vec');
end

