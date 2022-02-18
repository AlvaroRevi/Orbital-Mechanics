function tests = test_mycode % Top function that matlab uses to identify this as a test suite
    clc; % optional: cleans console
    tests = functiontests(localfunctions); % See the help if you want more info
end

%----------------------------------------------------------------------
%----------------------------------------------------------------------
%----------------------------------------------------------------------
 
function test_linearproblem(~) 
    f = @(x) x;
    df = @(x) 1;
    tolerance = 1e-8;
    maxiter = 100;
    x0 = 1.3;
    
    [x,abserr,relerr,iter] = newton(f,df,x0,tolerance,maxiter);
    
    assert(abs(x) < tolerance);
    assert(iter == 1);    
end 

function test_quadraticproblem(~) 
    f = @(x) x^2-1;
    df = @(x) 2*x;
    tolerance = 1e-8;
    maxiter = 100;
    x0 = 1.1;
    
    [x,abserr,relerr,iter] = newton(f,df,x0,tolerance,maxiter);
    
    assert(abs(x-1) < tolerance); 
end 

function test_ex13(~) 
    f = @(x) cos(x)-x;
    df = @(x) -sin(x)-1;
    tolerance = 1e-8;
    maxiter = 100;
    x0 = 0.75;
    
    [x,abserr,relerr,iter] = newton(f,df,x0,tolerance,maxiter);
     
    assert(abs(f(x)) < tolerance)
    
end 