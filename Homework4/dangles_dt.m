function dangles_dt = dangles_dt(mu,a,e,w,nu,angles,omega_b0)
% Provide the time derivative of the Euler angles of Sb with respect to St 
%       Inputs: 
%             mu: Gravtitational constant 
%             a: Semi-major axis
%             e: eccentricity 
%             w: unit vector along h 
%             nu: true anomaly 
%             angles: row vector with the three Euler angles
%             omega_b0: angular velocity vector 
%        Outputs: 
%             dangles_dt: time derivative of the Euler angles 


% % Unpack omega_b0
% omega_b0nominal=nominal_hw(mu,a,e,w,nu);
% 
% % Get omegaSb_Sℓ, Sb with respect to Sℓ (basis S0)
% omegaSb_Sl = omega_b0 - omega_b0nominal;
% 
% % Rotate omegaSb_Sℓ to basis Sℓ
% O_R_L = rotation_w(w,nu);
% omegaSb_Sl = O_R_L' *omegaSb_Sl;
% 
% omegax = omegaSb_Sl(1);
% omegay = omegaSb_Sl(2);
% omegaz = omegaSb_Sl(3);

omega_b0nominal=nominal_hw(mu,a,e,w,nu);

omegaSBtoSL=omega_b0-omega_b0nominal;

O_R_L = rotation_w(w,nu);
omegaSBtoSL=(O_R_L')*omegaSBtoSL;

omegax=omegaSBtoSL(1);
omegay=omegaSBtoSL(2);
omegaz=omegaSBtoSL(3);
% omegax = omega_b0(1)-omega_b0nominal(1);
% omegay = omega_b0(2)-omega_b0nominal(2);
% omegaz = omega_b0(3)-omega_b0nominal(3);

% Unpack Euler angles 
psi = angles(1); 
theta = angles(2); 
phi = angles(3); 

% Equations 
dangles_dt = zeros(3,1);

dangles_dt(1,1) = omegaz-((omegax-((omegay+omegax/tan(psi))/(sin(psi)+(cos(psi))^2/sin(psi)))*cos(psi))/(sin(theta)*sin(psi)))*cos(theta);
dangles_dt(2,1) = (omegay+omegax/tan(psi))/(sin(psi)+(cos(psi))^2/sin(psi));
dangles_dt(3,1) = (omegax-((omegay+omegax/tan(psi))/(sin(psi)+(cos(psi))^2/sin(psi)))*cos(psi))/(sin(theta)*sin(psi));

end 