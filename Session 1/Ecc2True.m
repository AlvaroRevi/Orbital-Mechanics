function theta = Ecc2True(E,e)
    y = ((1-e.^2).^(1/2).*sin(E))./(1-e.*cos(E)); %sin
    x = (cos(E)-e)./(1-e.*cos(E)); %cos
    
    theta = atan2(y,x);
end