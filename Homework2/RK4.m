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
    n = length(t)-1;

% Define the initial condition introduced as input
 X(:,1) = X0;
 
% Integrate applying RK4 
    for i = 1:n
        k1 = Cowell(X(:,i),flag);
        k2 = Cowell(X(:,i)+dt*k1/2,flag);
        k3 = Cowell(X(:,i)+dt*k2/2,flag);
        k4 = Cowell(X(:,i)+k3,flag);
        X(:,i+1) = X(:,i)+((k1+2*k2+2*k3+k4)/6)*dt;
    end
end