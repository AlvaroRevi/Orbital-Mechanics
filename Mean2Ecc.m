function E = Mean2Ecc(Me,e)

    f = @(E) Me-E+e*sin(E);
    df = @(E) -1+e*cos(E);
    
    x0 = Me;
    tol = 1e-8;
    maxiter = 1000;
    
    E = newton(f,df,x0,tol,maxiter);
end