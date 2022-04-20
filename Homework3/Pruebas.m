mu = 3.986e5; 
a = 100000;
e = 0.1;
Omega = deg2rad(30);
omega = deg2rad(20);
i = deg2rad(15); 
vh = [1000,5000,0];

[theta,Dv] = hyperbola(mu,a,e,Omega,i,omega,vh);

