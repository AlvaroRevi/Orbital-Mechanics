function diffy = derECI(t,y,mu,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag) 
%       Inputs: 
%         t: time 
%         y: state vector 
%             y(1) -> x
%             y(2) -> y 
%             y(3) -> z
%             y(4) -> vx
%             y(5) -> vy 
%             y(6) -> vz 
%         uS: Sun vector 
%         mSC: mass of spacecraft 
%         A: Area 
%         Bc: ballistic coefficient 
%         flag_srp: flag for the solar radiation acceleration(True/False) 
%         flag_J2: flag for J2 acceleration(True/False)
%         flag_drag: flag for atmospheric drag acceleration (True/False)

    % ODE 
    diffy = zeros(6,1); 
    diffy(1) = y(4); 
    diffy(2) = y(5); 
    diffy(3) = y(6); 
    diffy(4) = -mu/norm(y(1:3))^3*y(1); 
    diffy(5) = -mu/norm(y(1:3))^3*y(2);
    diffy(6) = -mu/norm(y(1:3))^3*y(3);

    if flag_srp == true 
        rSC = [y(1);y(2);y(3)]; 
        force = srp_force(uS,rSC,A); 
        diffy(4) = diffy(4)+ force(1)/mSC; 
        diffy(5) = diffy(5)+ force(2)/mSC;
        diffy(6) = diffy(6)+ force(3)/mSC;
    end 

    if flag_J2 == true 
        rSC = [y(1);y(2);y(3)]; 
        acc = J2_acc(rSC); 
        diffy(4) = diffy(4)+ acc(1); 
        diffy(5) = diffy(5)+ acc(2);
        diffy(6) = diffy(6)+ acc(3);  
    end 

    if flag_drag == true 
        rSC = [y(1);y(2);y(3)]; 
        vSC = [y(4);y(5);y(6)];
        acc = drag_acc(rSC,vSC,Bc); 
        diffy(4) = diffy(4)+ acc(1); 
        diffy(5) = diffy(5)+ acc(2);
        diffy(6) = diffy(6)+ acc(3);
    end 
end 

  
    
    
