function plot_orbit(t,coe)
%Plot the evolution in time of the six COEs in a single plot
%     Input: 
%         coe: Classic Orbital Elements in a vector in the following order
%             coe(1): a       Semi-major axis 
%             coe(2): e       Eccentricity    
%             coe(3): i       Incidence angle 
%             coe(4): Omega   RAAN
%             coe(5): omega   Argument of perigee 
%             coe(6): theta   True anomaly         
    subplot(2,3,1)
    plot(t/(24*3600),coe(1,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$a$ [km]','Interpreter','latex')
    ylim([0,10000])

    subplot(2,3,2)
    plot(t/(24*3600),coe(2,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$e$','Interpreter','latex')
    ylim([0,1])
    
    subplot(2,3,3)
    plot(t/(24*3600),coe(3,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$i$ [rad]','Interpreter','latex')
    ylim([-pi,pi])

    subplot(2,3,4)
    plot(t/(24*3600),coe(4,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\Omega$ [rad] ','Interpreter','latex')
    ylim([-pi,pi])

    subplot(2,3,5)
    plot(t/(24*3600),coe(5,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\omega$ [rad] ','Interpreter','latex')
    ylim([-pi,pi])

    subplot(2,3,6)
    plot(t/(24*3600),coe(6,:),'k')
    xlabel('$t$ [days]','Interpreter','latex')
    ylabel('$\theta$ [rad]','Interpreter','latex')
    ylim([-pi,pi])
    xlim([0,1])
end
