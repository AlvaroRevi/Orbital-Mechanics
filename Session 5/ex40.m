clc;
clear;

% Earth-Sun orbit properties
period = 365*24*3600;
mu = 1327120e5;

% Earth properties
% nE = sqrt(mu/(a)^3);
RE = 6371;
J2 = 0.00108263;

% SSO required precession rate
T = 86169/14;
deltaOmega = T*2*pi/(365*3600*24);
a = (3.986e5*(T/(2*pi))^2)^(1/3);
p = a;
e=0;

% Inclination to set SSO
inc = acos(deltaOmega*((p/RE)^2)/(-3*pi*J2));