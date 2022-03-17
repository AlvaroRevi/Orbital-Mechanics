function acc = drag_acc_COE(COE,Bc) 
    
RE = 6731e3; 
muE = 3.986e14; 
g = 9.81; 

R = 8.314; 
T = -86.28 + 273.15; 
M = 29e-3; 
h0 = 86e3; 
p0 = 0.3734; 

a = COE(1); 
e = COE(2); 
inc = COE(3); 
Omega = COE(4); 
omega = COE(5); 
theta = COE(6); 

h = sqrt(muE*a*(1-e^2)); 
r = a*(1-e^2)/(1+e*cos(theta)); 
V = muE/h*[e*sin(theta); 1+e*cos(theta);0]

rho0 = p0/(R*T/M); 
H = R*T/(g*M); 
h = r - RE; 
rho = rho0*exp(-(h-h0)/H); 

acc = -1/(2*Bc)*rho*norm(V)*V; 

end



