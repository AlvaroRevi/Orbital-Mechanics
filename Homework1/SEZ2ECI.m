function  [r0,v0] = SEZ2ECI(r1,v1,rho,lambda,t) 
% Compute the position and velocity vectors (r0,v0) in ECI basis provided 
% the position and velocity vectors in SEZ basis, the radius (rho), the 
% latitude (lambda) of the observer from the center of the Earth, and the 
% the time since the observer crossed the Oxz plane.
%     Inputs: 
%         r1: position vector in SEZ basis [km] 
%         v1: velocity vector in SEZ basis [km]
%         rho: radius (in this case, radius f the Earth) [km]
%         lambda: latitude of the observer [rad]
%         t: time since the observer crossed the Oxz plane [s]
%     Outputs: 
%         r0: position vector in ECI basis [km]
%         v0: velocity vector in ECI basis [km]

% Compute the longitude of the observer considering the rotation of the
% Earth and the time passed from the Oxz plane 
global theta_dot 
theta = theta_dot*t;   % Longitude [rad]

lambda_aux = theta;
phi = lambda;
% Rotation matrix from S0 to S1
A_aux_1 = [cos(phi), 0, sin(phi); 
           0, 1, 0;
           -sin(phi), 0, cos(phi)];

A_0_aux = [cos(lambda_aux ) -sin(lambda_aux ) 0;
           sin(lambda_aux ), cos(lambda_aux ), 0;
           0, 0, 1];

A_0_1 = A_0_aux * A_aux_1;

% Rotation matrix from S1 to S0 
 A_1_0 = transpose(A_0_1);
if transpose(A_0_aux) == inv(A_0_aux) && transpose(A_aux_1) == inv(A_aux_1)
    disp('Puta madre');
end


% Compute r0 in SEZ basis and transform it into the ECI basis
r0_1 = [0,0,rho] + r1;     %r0 in S1
r0_0 = A_1_0*r0_1';         %r0 in S0 

% Compute the angular velocity 
w_10_0 = [0,0,theta_dot];  %w10 in S0 
w_10_1 = A_0_1*w_10_0';     %w10 in S1

% Compute v0 in S1 and transform it to S0 
v0_1 = rho*cross(w_10_1,[0,0,1]') + v1' + cross(w_10_1,r1'); 
v0_0 = A_1_0*v0_1; 

% Return outputs 
r0 = r0_0; 
v0 = v0_0; 

end