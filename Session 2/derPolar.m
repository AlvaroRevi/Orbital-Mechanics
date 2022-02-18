function dXdt = derPolar(t,X,a,alpha) 
% % Compute the derivative of the state vector 
%     Inputs: 
%         r: 
%         u: 
%         v: 
%         a: 
%         alpha: 
%     Outputs:
%         dXdt: derivative of the state vector 
dXdt = [ X(3); 
         X(4)/X(1); 
         X(4)^2/X(1) - 1/(X(1)^2) + a*sin(alpha); 
         -(X(3)*X(4)/X(1)) + a*cos(alpha)];
     
end