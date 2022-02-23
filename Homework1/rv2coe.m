function [a,e,RAAN,i,omega,theta] = rv2coe(r0,v0) 
%  Compute the classical orbital elements (COE) at the impact of
%  observations provided the position and velocity vectors. 
%     Inputs: 
%         r0: position vector in ECI basis 
%         v0: velocity vector in ECI basis 
%     Outputs: 
%         a: semi-major axis of the conic [km]
%         e: eccentricity 
%         RAAN: right ascension the ascending node [rad]
%         i: orbit inclination [rad]
%         omega: argument of periapsis [rad]
%         theta: true anomaly [rad] 
global muE 

% Compute the norm of r,v 
r = norm(r0); 
v = norm(v0); 

% Use vis-viva equation to compute a
a = (muE)/(2*muE/r -v^2);

% Compute the angular momentum, its norm, and the k vector normal to the 
% orbital plane (periphocal basis)

h_0 = cross(r0,v0); 
h = norm(h_0); 
k_p_0 = h_0/h;

% Compute the orbital parameter, the eccentricity and the eccentricity
% vector

p = h/muE; 
e = sqrt(1 - (p/a)); 
e_0 = (v^2 - (muE/r))*r0/muE - (dot(r0,v0)/muE)*v0;

assert(norm(e_0)==e)


error('In process...')

end