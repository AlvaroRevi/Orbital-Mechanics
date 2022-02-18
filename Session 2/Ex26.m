clc; clear; close all; 








r_0 = 1; 
theta_0 = 0; 
u_0 = 0; 
v_0 = 1; 

% Optimization parameters
N_opt = 10; 

% Zip initial conditions
X_0 = [r_0, theta_0, u_0, v_0]; 

% Vector of times 
t_alpha = linspace(0,t_f, N_opt); 

% Integrator options 
% odeoptions = odeset('AbsTol',1E-6,'RelTol',1E-6); 
odeoptions = odeset(); 

% Objective function
fun = @(alpha) performanceIndex(t_alpha,alpha,T,dm,X0,odeoptions);

% Constraints function
constr = @(alpha) constraintFcn(t_alpha,alpha,T,dm,X0,odeoptions);

%Upper and lower bounds
lb = 0*t_alpha - pi;
ub = 0*t_alpha + pi;

% Check (exercise 25)
alpha_0 = 0*t_alpha;

% Optimize
options = optimoptions('fmincon','Display','iter','MaxFunction');
[alpha_opt, f_opt] = fmincon(fun, alpha_0, [],[],[],[],lb,ub, constr,);