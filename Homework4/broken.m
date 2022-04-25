function omega_b0 = broken(w,nu,angles,H_G0)
% Tensor of inertia of b+w
    I_fullG = diag([220,180,300]); 
    
    % Rotate from Bb to Bl (local reference frame)
    Bl_R_Bb = rot3(3,angles(1))*rot3(1,angles(2))*rot3(3,angles(3)); 
    
    % Rotate from Bl to B0 (ECI)
    B0_R_Bl = rotation_w(w,nu);
    
    % Full rotation from Bb to B0
    B0_R_Bb = B0_R_Bl * Bl_R_Bb;
    
    % Eq.8.33. Required to transform H_G0 & omega_b0 from B0 to Bb
    omega_b0 = linsolve(I_fullG,B0_R_Bb' * H_G0);
      
end