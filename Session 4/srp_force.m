function force = srp_force(u_s,r_SC,A)
%     Implement a function to compute the solar radiation force vector on a perfectly-absorbing
%     spacecraft at 1 AU from the Sun, given the Sun vector, the spacecraft position vector and its
%     front area A. The function shall detect when the spacecraft is in the shade of the Earth and
%     return a null force. For simplicity, assume that the shade of the Earth is a perfect cylinder.
%     Return the force in equatorial-ECI components.
%         Input: 
%             u_s: Sun vector (unit vector pointing towards the sun)
%             r_SC: Position in ECI
%             A: Front area
%         Output: 
%             force: Solar radiation force vector
    % Parameters 
    R_earth = 6371e3; 
    P_s = 4.56e-6; 
    
    % 
    r_SC_para = dot(r_SC,-u_s); 
    absrSCperp = norm(r_SC - r_SC_para*(-u_s)); 
    
    if r_SC_para >= 0 && absrSCperp <= R_earth 
        force = [0;0;0]; 
    else 
        force = -P_s*A*u_s; 
    end
end
    

