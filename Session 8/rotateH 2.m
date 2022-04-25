function H_basisB = rotateH(H_basis0,angles)

% H_basis0: angular momentum in basis 0

% angles: euler angles
    % angles(1) = psi
    % angles(2) = theta
    % angles(3) = phi 

bR0 = (rot3(3,angles(1)) *rot3(1,angles(2)) *rot3(3,angles(3)))';

H_basisB = bR0*H_basis0;
end