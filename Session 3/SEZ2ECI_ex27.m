function  [r0,v0] = SEZ2ECI_ex27(r_SEZ,v_SEZ,rho,lambda,t, init_long) 
% Compute the position and velocity vectors (r0,v0) in ECI basis provided 
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
%         r_SEZ: position vector in SEZ basis [km] 
%         v_SEZ: velocity vector in SEZ basis [km]
%         rho: radius (in this case, radius of the Earth) [km]
%         lambda: latitude of the observer [rad]
%         t: time since the observer crossed the Oxz plane [s]
%         init_long: longitude of the object when ECI an ECEF are alligned
%         [rad]
%     Outputs: 
%         r0: position vector in ECI basis [km]
%         v0: velocity vector in ECI basis [km]

% Compute the longitude of the observer considering the rotation of the
% Earth and the time passed from the Oxz plane 
global angular_rate 
varphi = angular_rate*t;        % Longitude [rad]

varphi = varphi + init_long; 

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
r0_2 = [0;0;rho] + r_SEZ;        %r0 in S2
r0_0 = A_0_1*A_1_2*r0_2;         %r0 in S0 

% Compute the angular velocity 
w_20_0 = [0;0;angular_rate];     %w20 in S0 

% Compute v0 in ECI (S0) using Coriolis theorem 
v0_0 = v_SEZ + cross(w_20_0,r0_0); 

% Return outputs 
r0 = r0_0; 
v0 = v0_0; 

end