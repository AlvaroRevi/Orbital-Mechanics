% Exercise 28 
clear; clc; close all 
muE = 398600;
% Position vector in ECI basis for the three observations 
r1 = [-2014.52,4254.09,5409];
r2 = [-9550.16,-1683.95,9097.54]; 
r3 = [3596.23, -7594.21, -9657.16]; 

% Check that the three positions are coplanar
assert(dot(r1,cross(r2,r3)) < 1e-5); 

% Use r2 as reference and compute D, N and S 
D = cross(r2,r3) + cross(r2,r1) + cross(r1,r2) ; 
N = norm(r1)*(cross(r2,r3))+norm(r2)*cross(r3,r1)+norm(r3)*cross(r1,r2); 
S = (norm(r2)-norm(r3))*r1 + (norm(r3)-norm(r1))*r2 + (norm(r1) - norm(r2))*r3; 

v2 = (1/norm(r2))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r2) + sqrt(muE/(norm(N)*norm(D)))*S; 

[a,e,RAAN,i,omega,theta] = rv2coe(r2,v2)

RAAN = rad2deg(RAAN); 
i = rad2deg(i);
omega = rad2deg(omega);
theta = rad2deg(theta); 