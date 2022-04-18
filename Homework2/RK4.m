function X = RK4(X0,dt,flag)


    K1 = X0;
    K2 = X0 + (dt/2)*Cowell(K1,flag);
    K3 = X0 + (dt/2)*Cowell(K2,flag);
    K4 = X0 + dt*Cowell(K3,flag);
    X = X0 + (dt/6)* (Cowell(K1,flag) + 2*Cowell(K2,flag) + 2*Cowell(K3,flag) + Cowell(K4,flag));

end