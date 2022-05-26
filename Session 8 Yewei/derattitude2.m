function dydt = derattitude2(t,y,Ix,Iy,Iz)

    phi = y(1);
    theta = y(2); 
    psi = y(3); 
    omegax = y(4) 
    omegay = y(5) 
    omegaz = y(6)

    dydt(1,1) = 1/sin(theta) *(omegax*sin(phi)+omegay*cos(phi));
    dydt(2,1) = omegax*cos(phi)-omegay*sin(phi);
    dydt(3,1) = omegaz - dydt(1,1)*cos(theta);
    dydt(4,1) = (Iy - Iz)*omegay*omegaz/Ix; 
    dydt(5,1) = (Iz - Ix)*omegax*omegaz/Iy;
    dydt(6,1) = (Ix - Iy)*omegax*omegay/Iz;

end