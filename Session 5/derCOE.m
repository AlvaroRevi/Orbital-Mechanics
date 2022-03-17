function diffy = derCOE(t,y,mu,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag) 
%       Inputs: 
%         t: time 
%         y: state vector 
%             y(1) -> a
%             y(2) -> e 
%             y(3) -> inc
%             y(4) -> RAAN
%             y(5) -> w
%             y(6) -> theta 
%         uS: Sun vector 
%         mSC: mass of spacecraft 
%         A: Area 
%         Bc: ballistic coefficient 
%         flag_srp: flag for the solar radiation acceleration(True/False) 
%         flag_J2: flag for J2 acceleration(True/False)
%         flag_drag: flag for atmospheric drag acceleration (True/False)

    % ODE 
    COE = y;
    
    
    
    a = COE(1); 
    e = COE(2); 
    inc = COE(3); 
    Omega = COE(4); 
    omega = COE(5); 
    theta = COE(6); 
    
    h = sqrt(muE*a*(1-e^2)); 
    r = a*(1-e^2)/(1+e*cos(theta));
    
    accr = 0;
    acctheta = 0; 
    accw = 0;
    if flag_srp == true 
      force = srp_force_COE(uS,COE,A); 
      accr = accr + force(1)/mSC; 
      acctheta = acctheta + force(2)/mSC;
      accw = accw + force(3)/mSC;
    end 

    if flag_J2 == true 
        acc = J2_acc_COE(COE); 
        accr = accr + acc(1); 
        acctheta = acctheta + acc(2); 
        accw = accw + acc(3); 
    end 

    if flag_drag == true 
        rSC = [y(1);y(2);y(3)]; 
        vSC = [y(4);y(5);y(6)];
        acc = drag_acc(rSC,vSC,Bc); 
        diffy(4) = diffy(4)+ acc(1); 
        diffy(5) = diffy(5)+ acc(2);
        diffy(6) = diffy(6)+ acc(3);
    end 
    
    diffa = 2*a^2/h*(e*sin(theta)*accr+(1+e*cos(theta))*acctheta); 
    diffe = h/mu*(sin(theta)*(accr+cos(theta)+(e+cos(theta))/(1+e*cos(theta)))*acctheta); 
    diffinc = r*cos(omega + theta)/h*accw; 
    diffOmega = r*sin(omega + theta)/(h*sin(inc))*accw; 
    diffomega = -h/(mu*e)*(cos(theta)*accr-((2+e*cos(theta))/(1+e*cos(theta)))*sin(theta)*acctheta)-r*sin(omega+theta)/(h*tan(inc))*accw;
    difftheta = h/r^2 + h/(mu*e)*(cos(theta)*accr-((2+e*cos(theta))/(1+e*cos(theta)))*sin(theta)*acctheta);
    
    diffy = [diffa;diffe;diffinc;diffOmega;diffomega;difftheta] 
end 
