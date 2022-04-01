%%% Exercise 29 
r1 = [15945.34, 0, 0];
r2 = [12214.83899, 0, 10249.64731]; 

Dt = 76*60; 
mu = 3.986e5;  
k = -cross(r1,r2)/norm(cross(r1,r2)); 
[a,e,Omega,i,omega,theta1,theta2] = Lambert_solve(mu,r1,r2,Dt,k); 