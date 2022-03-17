function acc_p=J2_acc_COE(COE)

%   INPUTS
%   COE = [a, (semi major axis)
%          e, (eccentricity)
%          i, (inclination)
%          node, (right ascension of ascending node)
%          arg, (argument of perigee)
%          true (true anomaly) ]

    mu_E = 1327120e5; % km3/s2
    R_E = 6371; %km
    a = COE(1);
    e = COE(2);
    inc = COE(3);
    Omega = COE(4);
    omega = COE(5);
    theta = COE(6);
    
    r_SC = a*(1-e^2)/(1+e*cos(theta));
    u = omega+theta;

    J2 = 0.00108263;

    acc_p = 3*J2*mu_E*(R_E^2)/(2*r_SC^4) * [3*(sin(inc)^2)*(sin(u)^2)-1;2*sin(inc)^2*sin(u)*cos(u);-2*sin(inc)*cos(inc)*sin(u)];

end