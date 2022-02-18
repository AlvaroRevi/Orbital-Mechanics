
function x = newton(f,df,x,tol,maxiter) 
    
    if  ~exist('tol', 'var')
        tol = 1e-8;
    end

    if  ~exist('maxiter', 'var')
        maxiter = 1000;
    end
    
    iter = 1; 
    
    while (abs(f(x)) > tol) && (iter < maxiter) 
        x0 = x; 
        x = x0 - (f(x0)/df(x0)); 
        iter = iter +1;
        
         if isinf(x) || isnan(x) || (iter>maxiter)
             fprintf('THE SOLUTION DIVERGED.');
         end
         
    end 
    
   
 
end
 
 