
function x = newton(f,df,x0, tol, maxiter)
% Newton-Rhapson routine with inputs: 
% f: function handle to be solved 
% df: derivative of f 
% x0: Initial guess 
% tol: Tolerance 
% maxiter: max number of iterations 

% Default value for tol and maxiter if not given 
if ~exist('tol', 'var')
   tol = 1e-8;
end

if ~exist('maxiter', 'var')
  maxiter = 1000;
end

% Initialize solution and interation number
x_old = x0; 
i = 0; 

% Iterate while the value of the function is not close enough to zero as 
% measured by the tolerance 
while abs(f(x_old)) > tol && i < maxiter 
    % Print iteration info 
    fprintf('Iteration: %d  x= %.5f  f(x) = %.5E\n',i,x_old,f(x_old))

    % Update solution into Newton iterative scheme
    x_new = x_old - f(x_old)/df(x_old); 
    
    % Prepare next iteration
    x_old = x_new;  
    i = i +1;
end 
    
% Check the validity of the solution and raise error if needed
% if isinf(x) || isnan(x) || (iter>maxiter)
%     error('THE SOLUTION DIVERGED.');
% end    

% Print final solution
fprintf('\nSolution converged\n')
fprintf('Iteration: %d  x= %.5f  f(x) = %.5E\n',i,x_old,f(x_old))
x = x_old;

end
 
 