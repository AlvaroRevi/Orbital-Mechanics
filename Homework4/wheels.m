function [omegaA,omegaB,omegaC] = wheels(w,nu,angles,omega_b0,H_G0)
    
    % Tensor of inertia of b+w
    I_fullG = diag([220,180,300]); 
    
    % Individual wheel tensor of inertia
    r = 0.05; 
    m = 2; 
    Iw = m*r^2/2; 
    
    % Rotate from Bb to Bl (local reference frame)
    Bl_R_Bb = rot3(3,angles(1))*rot3(1,angles(2))*rot3(3,angles(3)); 
    
    % Rotate from Bl to B0 (ECI)
    B0_R_Bl = rotation_w(w,nu);
    
    % Full rotation from Bb to B0
    B0_R_Bb = B0_R_Bl * Bl_R_Bb;
    
    % Eq.8.33. Required to transform H_G0 & omega_b0 from B0 to Bb
    omegas = (B0_R_Bb' * H_G0 - I_fullG * B0_R_Bb' * omega_b0')/Iw;

    omegaA = omegas(1);
    omegaB = omegas(2);
    omegaC = omegas(3);
end