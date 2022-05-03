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


% Unpack omega_b0 
omega_b0nominal=nominal_hw(mu,a,e,w,nu); 
omegax = omega_b0(1)-omega_b0nominal(1);
omegay = omega_b0(2)-omega_b0nominal(2);
omegaz = omega_b0(3)-omega_b0nominal(3);

% Unpack Euler angles 
psi = angles(1); 
theta = angles(2); 
phi = angles(3); 

% Equations 
dangles_dt = zeros(3,1);

dangles_dt(1,1) = 1/sin(theta) * ((2*omegax/sin(psi)) - omegay*cos(psi) - omegax*sin(psi));
dangles_dt(2,1) = omegax*cos(psi) + omegay*sin(psi);
dangles_dt(3,1) = omegaz - dangles_dt(1,1)*cos(theta);

end 