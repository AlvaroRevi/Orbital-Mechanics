function [omegaA,omegaB,omegaC] = wheels(w,nu,angles,omega_b0,H_G0)

I_fullG = diag([220,180,300]); 

r = 0.05; 
m = 2; 
I1 = m*r^2/2; 

Bl_R_Bb = rot3(3,angles(1))*rot3(1,angles(2))*rot3(3,angles(3)); 

B0_R_Bl = 
end