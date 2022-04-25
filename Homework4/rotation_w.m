function O_R_L = rotation_w(w,nu)
    
    % INPUTS:
        % w = unit vector along h
        % nu = true anomally
   
    % OUTPUTS:
        %O_R_L = rotation matrix from local reference frame to ECI

    w1 = w(1);
    w2 = w(2);
    w3 = w(3);

    O_R_L = [cos(nu) -sin(nu) 0; ...
             sin(nu) cos(nu) 0; ...
             w1 w2 w3];

end