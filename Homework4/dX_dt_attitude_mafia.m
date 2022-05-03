function dX_dt = dX_dt_attitude_mafia(mu,a,e,w,X,HG0)

% State vector is X = [nu, psi, theta, phi]
dX_dt(1,1) = norm(nominal_hw(mu,a,e,w,X(1)));

omegab0 = broken(w,X(1),X(2:4),HG0); 

dX_dt(2:4,1) = dangles_dt(mu,a,e,w,X(1),X(2:4),omegab0);
end