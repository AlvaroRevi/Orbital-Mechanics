function X = RK4(X0,dt,flag)

    tf = 90*24*3600;
    t = 0:dt:tf;

    n = length(t)-1;
    X(:,1) = X0;
    for i = 1:n
        k1 = Cowell(X(:,i),flag);
        k2 = Cowell(X(:,i)+dt*k1/2,flag);
        k3 = Cowell(X(:,i)+dt*k2/2,flag);
        k4 = Cowell(X(:,i)+k3,flag);
        X(:,i+1) = X(:,i)+((k1+2*k2+2*k3+k4)/6)*dt;
    end
    
end