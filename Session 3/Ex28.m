% Exercise 28 
clear; clc; close all 
muE = 398600;

% Position vector in ECI basis for the three observations 
r1 = [-2014.52,4254.09,5409];
r2 = [-9550.16,-1683.95,9097.54]; 
r3 = [3596.23, -7594.21, -9657.16]; 

% Check that the three positions are coplanar
raux = cross(r2./norm(r2),r3./norm(r3));
assert(abs(dot(r1./norm(r1),raux./norm(raux))) < 1e-4); 

% Use r2 as reference and compute D, N and S 
D = cross(r2,r3) + cross(r2,r1) + cross(r1,r2) ; 
N = norm(r1)*(cross(r2,r3))+norm(r2)*cross(r3,r1)+norm(r3)*cross(r1,r2); 
S = (norm(r2)-norm(r3))*r1 + (norm(r3)-norm(r1))*r2 + (norm(r1) - norm(r2))*r3; 

% Compute velocity vector using the Gibbs formula 
v1 = (1/norm(r1))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r1) + sqrt(muE/(norm(N)*norm(D)))*S; 
v2 = (1/norm(r2))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r2) + sqrt(muE/(norm(N)*norm(D)))*S; 
v3 = (1/norm(r3))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r3) + sqrt(muE/(norm(N)*norm(D)))*S; 

v1 = (1/norm(r1))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r1) + sqrt(muE/(norm(N)*norm(D)))*S;
v3 = (1/norm(r3))*sqrt(muE/(norm(N)*norm(D)))*cross(D,r3) + sqrt(muE/(norm(N)*norm(D)))*S;

X1 = vertcat(r1',v1'); 
X2 = vertcat(r2',v2'); 
X3 = vertcat(r3',v3'); 

% Get the Classical Orbit Elements starting from position and velocity
% vectors
<<<<<<< Updated upstream
[a1,e1,RAAN1,i1,omega1,theta1] = rv2coe(r1,v1);
% RAAN1 = rad2deg(RAAN1); 
% i1 = rad2deg(i1);
% omega1 = rad2deg(omega1);
% theta1 = rad2deg(theta1); 

[a2,e2,RAAN2,i2,omega2,theta2] = rv2coe(r2,v2);
% RAAN2 = rad2deg(RAAN2); 
% i2 = rad2deg(i2);
% omega2 = rad2deg(omega2);
% theta2 = rad2deg(theta2); 

[a3,e3,RAAN3,i3,omega3,theta3] = rv2coe(r3,v3);
% RAAN3 = rad2deg(RAAN3); 
% i3 = rad2deg(i3);
% omega3 = rad2deg(omega3);
% theta3 = rad2deg(theta3); 
=======
% [a,e,RAAN,i,omega,theta] = rv2coe(r2,v2);
% RAAN = rad2deg(RAAN); 
% i = rad2deg(i);
% omega = rad2deg(omega);
% theta = rad2deg(theta); 

coe1 = stat2coe(X1,muE);
coe2 = stat2coe(X2,muE);
coe3 = stat2coe(X3,muE);
>>>>>>> Stashed changes
