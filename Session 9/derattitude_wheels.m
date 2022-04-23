function dydt = derattitude_wheels(t,y,Ix,Iy,Iz,Br,Q,OmegaR)
    
    psi = y(1);
    theta = y(2);
    phi = y(3);
    omegax = y(4);
    omegay = y(5);
    omegaz = y(6);
    
    if t<5
        OmegaR = Q*t/Br;
    else
        OmegaR = Q/Br;
    end

    Mx = -Br*OmegaR*omegay;
    My = Br*OmegaR*omegax;
    Mz = -Q;

    dydt(1,1) = (omegax*sin(phi)+omegay*cos(phi))/sin(theta);
    dydt(2,1) = omegax*cos(phi)-omegay*sin(phi);
    dydt(3,1) = omegaz - dangles_dt(1,1)*cos(theta);
    dydt(4,1) = (Mx + (Iy-Iz)*omegay*omegaz)/Ix;
    dydt(5,1) = (My + (Iz-Ix)*omegax*omegaz)/Iy;
    dydt(6,1) = (Mz + (Ix-Iy)*omegax*omegay)/Iz;

end