 function [theta,Dv] = hyperbola(mu,a,e,Omega,i,omega,vh)
% Find the parking orbit true anomaly (theta) and the injection impulse Dv
% to go from parking orbit to escape hyperbola.
%
% Inputs:
%    mu: gravitational parameter [km^3/s^2]
%    a: semi-major axis of the ellipse [km]
%    e: eccentricity
%    Omega: RAAN 
%    i: inclination angle 
%    omega: argument of periapsis 
%    vh: scape velocity vector 
%
% Output: 
%    theta: true anomaly of the parking orbit
%    Dv: injection impulse

% Compute orbital parameter and angular momentum 
p = a*(1-e^2); 
h = sqrt(mu*p); 

% Span the vector of thetas and compute the radius associated to each 
theta_span = linspace(0,2*pi,360);

% For each theta, compute the radius of the orbit associated. Then, compute
% the radius vector associated 
r_span = zeros(1,length(theta_span));

% Create variables to store the latter best combination
theta_min = 0;
DeltaV_min = 1e5;

for i = 1:length(theta_span)

    % Compute the r and the v associated to each theta in ICRF        
    X = coe2stat([a,e,i,Omega,omega,theta_span(i)],mu);
    r = stat(1:3); 
    v = stat(4:end); 

    % Compute the normal of the orbital plane 
    normal = cross(r,vh)/norm(cross(r,vh));
    
    % Compute the vectors of the B plane
    
    s = vh/norm(vh); 
    t = cross(s,normal)/(norm(s)*norm(normal));
    m = cross(normal,t);
    u = cross(s,t);

    B = sqrt(r_span(i)^2 + (2*r_span(i)*mu/(norm(vh)^2))); 
    B_vec = B*cos(theta_span(i))*t + B*sin(theta_span(i))*u;
    
    v1_ep = ;
    v1_cc = ;

    DeltaV(i) = v1_ep - v1_cc;

    if DeltaV(i)<DeltaV_min
        DeltaV_min = DeltaV(i);
        theta_min = theta_span(i);
    end
end

end