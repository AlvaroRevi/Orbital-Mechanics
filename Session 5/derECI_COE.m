function diffy = derECI_COE(t,COE,mu,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag) 
%       Inputs: 
%         t: time 
%         COE: classical orbital elements
%           COE(1) = a, (semi major axis)
%           COE(2) = e, (eccentricity)
%           COE(3) = i, (inclination)
%           COE(4) = node, (right ascension of ascending node)
%           COE(5) = arg, (argument of perigee)
%           COE(6) = true (true anomaly) ]
%         uS: Sun vector 
%         mSC: mass of spacecraft 
%         A: Area 
%         Bc: ballistic coefficient 
%         flag_srp: flag for the solar radiation acceleration(True/False) 
%         flag_J2: flag for J2 acceleration(True/False)
%         flag_drag: flag for atmospheric drag acceleration (True/False)

    a = COE(1);
    e = COE(2);
    inc = COE(3);
    Omega = COE(4);
    omega = COE(5);
    theta = COE(6);
    h = sqrt(mu*a*(1-e^2));
    r = a*(1-e^2)/(1+e*cos(theta));

    accr = 0;
    acctheta = 0;
    accw = 0;

    % ODE 

%     if flag_srp == true 
%         rSC = [y(1);y(2);y(3)]; 
%         force = srp_force(uS,rSC,A); 
%         diffy(4) = diffy(4)+ force(1)/mSC; 
%         diffy(5) = diffy(5)+ force(2)/mSC;
%         diffy(6) = diffy(6)+ force(3)/mSC;
%     end 

    if flag_J2 == true 
        acc = J2_acc_COE(COE); 
        accr = accr+acc(1);
        acctheta = acctheta+acc(2);
        accw = accw+acc(3);
    end 

    if flag_drag == true 
        acc = drag_acc_COE(COE,Bc); 
        accr = accr+acc(1);
        acctheta = acctheta+acc(2);
        accw = accw+acc(3);
    end 

    diffa = 2*a^2/h*(e*sin(theta)*accr+(1+e*cos(theta))*acctheta); 
    diffe = h/mu*(sin(theta)*(accr+cos(theta)+(e+cos(theta))/(1+e*cos(theta)))*acctheta); 
    diffinc = r*cos(omega + theta)/h*accw; 
    diffOmega = r*sin(omega + theta)/(h*sin(inc))*accw; 
    diffomega = -h/(mu*e)*(cos(theta)*accr-((2+e*cos(theta))/(1+e*cos(theta)))*sin(theta)*acctheta)-r*sin(omega+theta)/(h*tan(inc))*accw;
    difftheta = h/r^2 + h/(mu*e)*(cos(theta)*accr-((2+e*cos(theta))/(1+e*cos(theta)))*sin(theta)*acctheta);

    diffy = [diffa;diffe;diffinc;diffOmega;diffomega;difftheta];
end 