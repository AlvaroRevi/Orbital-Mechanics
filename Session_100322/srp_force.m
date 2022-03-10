function force = srp_force(uS,r_sc,A)
    RE = 6371e3; 

    rSCpara = dot(r_sc,-uS);
    absrSCperp = norm(r_sc-rscpata*(-uS));
    P_sun = 4.56e-6; %N/m2

    if rSCpara>=0 && absrSCperp<=RE
        force = [0 0 0];
    else
        force = -P_sun*A*uS;
    end

end