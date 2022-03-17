function acc_p = J2_acc_COE(COE)
    
    J2 = 0.00108263; 
    RE = 6371*10^3;
    
    a = COE(1); 
    e = COE(2); 
    inc = COE(3); 
    Omega = COE(4); 
    omega = COE(5); 
    theta = COE(6); 

    r = a*(1-e^2)/(1+e*cos(theta)); 

    u = omega + theta; 
    
    acc_p = 1.5*J2*muE*RE^2/(r^4)*[3*sin(inc)^2*sin(u) -1; 
                                   2*sin(inc)^2*sin(u)*cos(u); 
                                   -2*sin(inc)*cos(inc)*sin(u)]; 
end