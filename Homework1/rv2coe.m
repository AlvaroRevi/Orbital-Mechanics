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
h = cross(r0,v0); 

error('In process...')

end