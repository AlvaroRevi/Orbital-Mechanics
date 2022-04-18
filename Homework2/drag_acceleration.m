function a = drag_acceleration(rho,BC,V)
%     Determine the perturbing acceleration due to drag on a spacecraft given 
%     its Bc, density (rho) and velocity vector V
%
%             Input: 
%                 rho: atmospheric density [kg/m^3]
%                 V: Velocity vector [km/s]
%                 B_c: Ballistic coefficient
%             Output:
%                 a: Perturbing acceleration due to atmospheric drag
%                 [m/s^2]
        
        % Convert velocity vector into SI 
%         V = V*1000; 
        
        % Compute drag 
        a = - 1/(2*BC)*rho*norm(V)*V; 
end 