function  [r2,v2] = ECI2SEZ(r_ECI,v_ECI,rho,lambda,t) 
% Compute the position and velocity vectors (r2,v2) in SEZ basis provided 
% the position and velocity vectors in SEZ basis, the radius (rho), the 
% latitude (lambda) of the observer from the center of the Earth, and the 
% the time since the observer crossed the Oxz plane.
%     Notes: 
%         ECI is referred as S0 
%         ECEF is referred as S1
%         SEZ is referred as S2 
%    The subindexes on the vector quantities indicate the basis in which 
%    they are expressed 
%
%     Inputs: 
%         r_ECI: position vector in ECI basis (introduced as row vector)[km] 
%         v_ECI: velocity vector in ECI basis (introduced as row vector)[km]
%         rho: radius (in this case, radius f the Earth) [km]
%         lambda: latitude of the observer [rad]
%         t: time since the observer crossed the Oxz plane [s]
%     Outputs: 
%         r2: position vector in SEZ basis [km]
%         v2: velocity vector in SEZ basis [km]

% Compute the longitude of the observer considering the rotation of the
% Earth and the time passed from the Oxz plane 
global angular_rate 
varphi = angular_rate*t;        % Longitude [rad]
 
% Rotation matrix from ECEF (S1) to ECI (S0)
A_0_1 = [cos(varphi), -sin(varphi), 0;
         sin(varphi), cos(varphi),0; 
         0,          0,           1]; 

% Rotation matrix from ECI (S0) to ECEF (S1) 
A_1_0 = transpose(A_0_1); 

% Rotation matrix from SEZ (S2) to ECEF (S1) 
A_1_2 = [sin(lambda), 0, cos(lambda); 
         0,           1,           0; 
         -cos(lambda), 0, sin(lambda)]; 

% Rotation matrix from ECEF (S1) to SEZ (S2)
A_2_1 = transpose(A_1_2); 

% Compute r0 in SEZ basis and transform it into the ECI basis
r2_2 = A_2_1*A_1_0*r_ECI - [0,0,rho];        %r2 in S2
r2_0 = A_0_1*A_1_2*r2_2';                    %r2 in S0 

% Compute the angular velocity 
w_20_0 = [0;0;angular_rate];     %w20 in S0 

% Compute v0 in ECI (S0) using Coriolis theorem 
v2_0 = v_ECI - cross(w_20_0,r_ECI); 
v2_2 = A_2_1*A_1_0*v2_0;

% Return outputs 
r2 = r2_2; 
v2 = v2_2; 

end