clc; clear; close all; 

% Numerical parameters 
T = 0.1405; 
m_dot = 0.07489; 
t_f =3.3155; 
a = 0; 

% Initial conditions 
r_0 = 1; 
theta_0 = 0; 
u_0 = 0; 
v_0 = 1;

% Zip initial conditions
X_0 = [r_0, theta_0, u_0,v_0]; 

% Linspace for the trajectory of the exercise 
t_span = linspace(0,t_f,1000); 

% Linspace of a full period 
t_span_2 = linspace(0,2*pi,1000); 

% When a=0, the trajectory will be circular 
alpha = 0; 
[t,X] = ode45(@(t,X) derPolar(t,X,a,alpha), t_span,X_0);
[t_2,X_2] = ode45(@(t,X) derPolar(t,X,a,alpha), t_span_2,X_0);

figure(1) 
hold on 
plot(X(:,1).*cos(X(:,2)),X(:,1).*sin(X(:,2)),'r-','LineWidth',2)
plot(X_2(:,1).*cos(X_2(:,2)),X_2(:,1).*sin(X_2(:,2)),'k--')
plot(0,0,'b.','MarkerSize',50)
axis equal

% When we change a into a(t) and alpha into alpha(t), the trajectory 
% will not be circular anymore 
a = @(t) T/(1 - m_dot*t); 
alpha = [pi/2,-pi];
[t,X] = ode45(@(t,X) derPolar_interp(t,X,a(t),alpha,t_f),t_span,X_0);


figure(2) 
hold on 
plot(X(:,1).*cos(X(:,2)),X(:,1).*sin(X(:,2)),'r-','LineWidth',2)
plot(X_2(:,1).*cos(X_2(:,2)),X_2(:,1).*sin(X_2(:,2)),'k--')
plot(0,0,'b.','MarkerSize',50)
axis equal

% 3D Plot  

% figure(1)
% plot3(X(:,1).*cos(X(:,2)),X(:,1).*sin(X(:,2)),zeros(length(t),1))
% hold on
% plot3(0,0,0,'b.','MarkerSize',50)
% hold off
% axis equal 





