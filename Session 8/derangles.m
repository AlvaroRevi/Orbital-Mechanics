function [psidot, thetadot, phidot] = derangles(angles,omega_b0)
    psi = angles(1);
    theta = angles(2);
    phi = angles(3);
    
    dangles_dt(1,1) = 1/sin(theta) *(omegax*sin(phi)+omegay*cos(phi));
    dangles_dt(2,1) = omegax*cos(phi)-omegay*sin(phi);
    dangles_dt(3,1) = omegaz - dangles_dt(1,1)*cos(theta);
end