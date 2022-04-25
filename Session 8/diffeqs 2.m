function dangles_dt = diffeqs(angles,H_basis0,I_basisb)

    H_basisb = rotateH(H_basis0,angles);
    
    omega0_basisb = compute_omegab0(H_basisb,I_basisb);
    omegax = omega0_basisb(1);
    omegay = omega0_basisb(2);
    omegaz = omega0_basisb(3);
    
    psi = angles(1);
    theta = angles(2);
    phi = angles(3);
    
    dangles_dt(1,1) = 1/sin(theta) *(omegax*sin(phi)+omegay*cos(phi));
    dangles_dt(2,1) = omegax*cos(phi)-omegay*sin(phi);
    dangles_dt(3,1) = omegaz - dangles_dt(1,1)*cos(theta);
end