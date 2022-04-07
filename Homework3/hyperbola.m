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
%    theta: true anomaly 
%    Dv: injection impulse


% Span the vector of thetas and compute the radius associated to each 
theta_span = linspace(0,2*pi,360);

% For each theta, compute the radius of the orbit associated. Then, compute
% the radius vector associated 

r_span = zeros(1,length(theta_span));


for i = 1:length(theta_span)

    r_span(i) = a*(1-e*(e+cos(theta_span(i))/(1+e*cos(theta_span(i)))));
    % Compute the r and the v associated to each theta in ICRF        
    stat = coe2stat([a,e,i,Omega,omega,theta_span(i)],mu);
    r = stat(1:3); 
    v = stat(4:end); 
    
    % Compute the normal of the orbital plane 
    normal = cross(r,vh);
    
    % Compute the vectors of the B plane
    
    n = [0,0,1];
    s = vh/norm(vh); 
    t = cross(s,n);
    m = cross(n,t);
    u = cross(s,t);

    B = sqrt(r_span(i)^2 + (2*r_span(i)*mu/(norm(vh)^2))); 

    B_vec = B*cos(theta_span(i))*t + B*sin(theta_span(i))*u;

end





end