 function [theta,Dv] = hyperbola(mu,a,e,Omega,i,omega,vh)
% Find the parking orbit true anomaly (theta) and the injection impulse Dv
% to go from parking orbit to escape hyperbola.
%
% Inputs:
% ... Parking orbit    
%    mu: gravitational parameter [km^3/s^2]
%    a: semi-major axis of the ellipse [km]
%    e: eccentricity
%    Omega: RAAN 
%    i: inclination angle 
%    omega: argument of periapsis 
%   
% ... Hyperbola
%    vh: scape velocity vector 
%
% Output: 
%    theta: true anomaly of the parking orbit
%    Dv: injection impulse

% Compute orbital parameter and angular momentum 
p = a*(1-e^2); 
h = sqrt(mu*p); 

% Compute impact parameter
B = h/norm(vh);

% Obtain SMA in hyperbola
a_h = -mu/(norm(vh)^2);

% Obtain e knowing SMA and B
e_h = sqrt((-B/a_h)^2 + 1);

% Span the vector of thetas and compute the radius associated to each 
theta_span = linspace(0,2*pi,360);

% Create variables to store the latter best combination
theta = 0;
Dv = 1e5;

for k = 1:length(theta_span)

    % Compute the r and the v associated to each theta in ICRF        
    X = coe2stat([a,e,i,Omega,omega,theta_span(k)],mu);
    r = X(1:3); 
    v = X(4:end); 
    
    % Compute speed at the hyperbola
    chi = (norm(vh)^2)/2;
    r_h = p/(1+e_h*cos(theta_span(k)));
    v1_h = 2*(chi + mu/r_h);

    % Compute spped in circular parking orbit
%     v1_cc = sqrt(mu/nomr(r));
    v1_cc = norm(v);
    
    % Compute tangential impulsive maneuver
    DeltaV(k) = abs(v1_h - v1_cc);

    if DeltaV(k)<Dv
        Dv = DeltaV(k);
        theta = theta_span(k);
    end
end

end