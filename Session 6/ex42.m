% Enrique Sentana Gómez & Álvaro Reviriego Moreno
% Ex42

clc;
clear;
close all

mu = 1327120e5;
a_earth = 149.67e6;
a_mars = 227.94e6;

n_fun = @(a) sqrt(mu/(a^3));
n_earth = n_fun(a_earth);
n_mars = n_fun(a_mars);

deltan = n_mars - n_earth;

% a) Synodic period
tau_s = (2*pi/abs(deltan))/(24*3600*365); % [years]

% b) Hohmann transfer
at = (a_earth+a_mars)/2;
et = (a_mars-a_earth)/(a_earth+a_mars); % or from rp = at(1-et^2)/(1+et) --> et = 1- rp/at

% c) S/C velocities to So
v0_tp = (2*mu*a_mars/(a_earth*(a_earth+a_mars)))^(1/2); % [km/s]
v0_ta = (2*mu*a_earth/(a_mars*(a_earth+a_mars)))^(1/2); % [km/s]

% d) Transfer time
delta_tt = pi*sqrt(at^3/mu)/(24*3600*365); % [years] half of the tranfer orbit period

% e) Relative phase of Mars as seen from Earth
phi1 = rad2deg(pi-n_mars*delta_tt*(24*3600*365)); % [deg]

% Upon arrival in mars
phi2 = rad2deg(pi-n_earth*delta_tt*(24*3600*365)); % [deg]

% f) 
k = 2;

delta_tw = (2*n_earth*delta_tt*(24*3600*365)/deltan +tau_s*(24*3600*365)*k)/(24*3600*365); % [years]

