clc;
clear;
close all

f = @(x) cos(x) - x; 
df = @(x) -sin(x) -1; 
tol = 1e-8; 
x_init = 0.75;
max_iters = 1000; 
x = newton(f,df,x_init,tol,max_iters);  