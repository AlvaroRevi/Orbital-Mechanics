clc; clear; close all; 

% Numerical parameters 
T = 0.1405; 
m_dot = 0.07489; 
t_f =10; 

% Initial conditions 
r_0 = 1; 
theta_0 = 0; 
u_0 = 0; 
v_0 = 1;

X_0 = [r_0, theta_0, u_0,v_0]; 



a = @(t) T/(1 - m_dot*t); 
%a = 0; 
 
t_span = linspace(0,t_f,1000); 



% alpha = 0; 
% [t,X] = ode45(@(t,X) derPolar(t,X,a(t),alpha), t_span,X_0);

alpha = [pi/2,-pi];
[t,X] = ode45(@(t,X) derPolar_interp(t,X,a(t),alpha,t_f),t_span,X_0);


figure(1) 
hold on 
plot(X(:,1).*cos(X(:,2)),X(:,1).*sin(X(:,2)))
plot(0,0,'b.','MarkerSize',50)
axis equal


% figure(1)
% plot3(X(:,1).*cos(X(:,2)),X(:,1).*sin(X(:,2)),zeros(length(t),1))
% hold on
% plot3(0,0,0,'b.','MarkerSize',50)
% hold off
% axis equal 





