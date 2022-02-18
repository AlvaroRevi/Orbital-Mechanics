
function time = theta2time(theta,a,e)
    mu = 3.986e5;
    E = True2Ecc(theta, e);
    Me = Ecc2Mean(E, e);
    time = Me/((mu/(a^3))^(1/2));
end
   