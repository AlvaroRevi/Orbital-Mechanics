function coe = stat2coe(X,mu) 
%  Compute the classical orbital elements (COE) at the impact of
%  observations provided the position and velocity vectors. 
%     Inputs: 
%         X: state vector with length 6 giving position and velocity of the
%            spacecraft in equatorial ECI frame
%            [x,y,z,vx,vy,vz]
%         mu: gravitational constant      
%     Outputs: 
%         coe: vector with classical orbital elements
%             a: semi-major axis of the conic [km]
%             e: eccentricity 
%             RAAN: right ascension the ascending node [rad]
%             i: orbit inclination [rad]
%             omega: argument of periapsis [rad]
%             theta: true anomaly [rad] 

% Unpack position and velocity from state vector
r0 = X(1:3); 
v0 = X(4:6);

% Compute the norm of r,v 
r = norm(r0);                 % Norm of the position vector 
v = norm(v0);                 % Norm of the velocity vector 

% Use vis-viva equation to compute a
a = (mu)/(2*mu/r -v^2);     % Semi-major axis [km]

% Compute the angular momentum, its norm, and the k vector normal to the 
% orbital plane (periphocal basis)

h_0 = cross(r0,v0);             % Angular momentum vector in ECI (S0) [kg*km^2/s] 
h = norm(h_0);                  % Angular momentum magnitude [kg*km^2/s]

% Compute the orbital parameter, the eccentricity and the eccentricity
% vector

p = h^2/mu;                    % Orbital parameter [km]
e = sqrt(1 - (p/a));            % Eccentricity [-]

e_0 = ((v^2) - (mu/r))*(r0/mu) - v0*(dot(r0,v0)/mu);     % Eccentricity vector in basis ECI (S0)

% Check that the norm of the eccentricity vector is equal to the computed
% eccentricity (tolerance: 1e-4)
%assert(abs(e - norm(e_0)) < 1e-4);

% Compute the periphocal vector basis
k_p_0 = h_0/h;                  % Periphocal vector k in basis ECI (S0) 
i_p_0 = e_0/norm(e_0);          % Periphocal vector i in basis ECI (S0)
j_p_0 = cross(k_p_0,i_p_0);     % Periphocal vector j in basis ECI (S0)

% Compute the inclination angle (k_p.k_0 = cos(i))
i = acos(dot(k_p_0,[0,0,1]));                     % Inclination angle [rad]

% Compute the auxiliary vectors n and m 
aux_1 = cross([0,0,1],h_0); 
n_0 = aux_1/norm(aux_1);        % Auxiliary vector n in basis ECI (S0)
m_0 = cross(h_0,n_0)/h;         % Auxiliary vector m in basis ECI (S0)

% Compute the argument of periapsis (w) 
omega = atan2(dot(i_p_0,m_0),dot(i_p_0,n_0));     % Arg. of periapsis [rad]

% Compute the RAAN 
RAAN = atan2(n_0(2),n_0(1));                      % RAAN [rad]

% Compute the true anomaly 
theta = atan2(dot(j_p_0,r0),dot(i_p_0,r0));       % True anomaly [rad]

% Return output vector 
coe =  [a;e;i;RAAN;omega;theta];
end