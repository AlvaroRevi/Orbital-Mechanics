function [omegaA,omegaB,omegaC] = wheels(w,nu,angles,omega_b0,H_G0)

    Iw = 2*((5/100)^2)/2; % same for all 3 wheels [kg m^2]
    
    psi = angles(1);
    theta = angles(2);
    phi = angles(3);
    
    aux = H_G0-I_G*omega_b0;

    omegaA = aux(1)/Iw;
    omegaB = aux(2)/Iw;
    omegaC = aux(3)/Iw;
end