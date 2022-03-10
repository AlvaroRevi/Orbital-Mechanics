function [diffy] = derECI(t,y,muE,uS,mSC,A,Bc,flag_srp,flag_J2,flag_drag)

    % ODE
    diffy = zeros(6,1);
    diffy(1) = y(4);
    diffy(2) = y(5);
    diffy(3) = y(6);
    diffy(4) = -muE/norm(y(1:3))^3 *y(1);
    diffy(5) = -muE/norm(y(1:3))^3 *y(2);
    diffy(6) = -muE/norm(y(1:3))^3 *y(3);

    if flag_srp==true
        rSC = [y(1) y(2) y(3)];
        force = srp_force(uS,rSC,A);
        diffy(4) = diffy(4) + force(1)/mSC;
        diffy(5) = diffy(5) + force(2)/mSC;
        diffy(6) = diffy(6) + force(3)/mSC;
    end

    if flag_J2==true
        rSC = [y(1) y(2) y(3)];
        acc = J2_acc(rSC);
        diffy(4) = diffy(4) + acc(1);
        diffy(5) = diffy(5) + acc(2);
        diffy(6) = diffy(6) + acc(3);
    end

    if flag_drag==true
        rSC = [y(1) y(2) y(3)];
        vSC = [y(4) y(5) y(6)];
        acc = drag_acc(rSC,vSC,Bc);
        diffy(4) = diffy(4) + acc(1);
        diffy(5) = diffy(5) + acc(2);
        diffy(6) = diffy(6) + acc(3);
    end
    
end