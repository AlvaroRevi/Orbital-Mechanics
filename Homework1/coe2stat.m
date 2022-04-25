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

% Compute the orbital parameter, the angular momentum and the radius of the orbit
   r = a*(1-e.^2)./(1+e*cos(theta));
   p = a*(1-e.^2);
   h = sqrt(mu*p);

% Compute the auxiliary basis B1 
    R1 = rot3(3,-Omega); 

    i_1 = [1,0,0]*R1; 
    j_1 = [0,1,0]*R1; 
    k_1 = [0,0,1]*R1;
% Compute the auxiliary basis B2
  i_2 = i_1; 
  j_2 = cos(i)*j_1 + sin(i)*k_1; 
  k_2 = -sin(i)*j_1 + cos(i)*k_1;
%   R2 = rot3(1,-i); 
%     i_2 = i_1*R2; 
%     j_2 = j_1*R2;
%     k_2 = k_1*R2;

% Compute the perifocal reference frame 
  i_PQR = cos(omega)*i_2 +sin(omega)*j_2; 
  j_PQR = -sin(omega)*i_2 + cos(omega)*j_2; 
  k_PQR = k_2; 
  
  r_vec = r*(cos(theta)*i_PQR + sin(theta)*j_PQR); 

  r_d = e*mu*sin(theta)/h;
  r_theta_d = h/r;

  v_vec = r_d*(cos(theta)*i_PQR + sin(theta)*j_PQR) + r_theta_d*(-sin(theta)*i_PQR+cos(theta)*j_PQR);

  % Return state vector 
  X = vertcat(r_vec',v_vec')
end

