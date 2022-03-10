function acc = drag_acc(r_sc,v_sc,Bc)

    RE = 6371e3;                        %m
    g = 9.80665;                        %m/s2

    T_0 = -86.28 +273.15;               % K
    M = 29/1000;                        % kg/mol
    P_0 = 0.3734;                       % Pa
    rho_0 = P_0/(R*T_0/M);              % kg/m3
    chi = 86e3;                         % km
    R = 8.314;                          % J/Kmol
    H = R*T/(g*M);
    
    h = norm(r_sc)-RE;                  % m
    rho = rho_0*exp(-(h-chi)/H);        % kg/m3

    acc = -rho*v_sc*norm(v_sc)/(2*Bc);  % m/s2

end