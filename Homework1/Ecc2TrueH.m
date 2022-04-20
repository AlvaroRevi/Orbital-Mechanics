function theta = Ecc2TrueH(H,e)
% Obtain the true anomaly of a hyperbolic orbit with H and e as inputs 
%
% Inputs: 
%     H: eccentric anomaly (rads) 
%     e: eccentricity 
%
% Output: 
%     theta: true anomaly

    y = ((e.^2-1).^(1/2).*sinh(H))./(e.*cosh(H)-1); %sin
    x = (e-cosh(H))./(e.*cosh(H)-1); %cos
    
    theta = atan2(y,x);
end