function X = RK4(X0,dt,flag)
% Runge-Kutta 4th order integrator that advances a timestep of dt. The
% function to integrate consist on the ODE from Cowell's formulation. If
% flag is enabled, the Cowell function will consider as well the
% perturbation acceleration due to atmospheric drag
%     Inputs: 
%         X0: Initial state vector 
%         dt: timestep 
%         flag: true if perturbation acceleration is considered
%     Output: 
%         X: State vector for each timestep 

% Define the linspace considering the timestep introduced as input 
    tf = 90*24*3600;
    t = 0:dt:tf;
    n = length(t) -1;

% Define the initial condition introduced as input
 X(:,1) = X0;
 
% Integrate applying RK4 
    for i = 1:n
        k1 = X(:,i);
        k2 = X(:,i) + Cowell(k1,flag)*dt/2;
        k3 = X(:,i)+ Cowell(k2,flag)*dt/2;
        k4 = X(:,i) + dt*Cowell(k3,flag);
        X(:,i+1) = X(:,i)+ (dt/6)*( Cowell(k1,flag) + 2*Cowell(k2,flag)+ 2*Cowell(k3,flag) + Cowell(k4,flag));
    end
end