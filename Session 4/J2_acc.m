function a_p = J2_acc(r_SC)
mu = 3.986e5;
R_e = 6371;
J2 = 0.00108263;

%     Compute the J2 acceleration in equatorial ECI as a function of its position
r = norm(r_SC); 
x = r_SC(1); 
y = r_SC(2); 
z = r_SC(3);

a_x = ((3*mu*J2*R^2)/(r^4)) * (x/r) * (2.5*((z/r)^2)-0.5);
a_y = ((3*mu*J2*R^2)/(r^4)) * (y/r) * (2.5*((z/r)^2)-0.5);
a_z = ((3*mu*J2*R^2)/(r^4)) * (z/r) * (2.5*((z/r)^2)-1.5);

a_p = [a_x;a_y;a_z];

end 