function E = True2Ecc(theta, e)

    y = ((1-e.^2).^(1/2).*sin(theta))./(1+e.*cos(theta)); %sin
    x = (e+cos(theta))./(1+e.*cos(theta)); %cos
    
    E = atan2(y,x);
end