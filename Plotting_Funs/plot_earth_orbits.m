function flag = plot_earth_orbits(spacecraft, orbits)
    % INPUTS:
    % spacecraft : Spacecraft Definitions. Array. Series of [[E_r,E_v],...]
    % orbits     : Orbital Definitions. Only consists of [[a,e,i],...]
    %              a - semi-major axis, e - eccentricity, i - inclination
    close all
    hold on
    c = constants();
    % figure;
    % spacecraft(1:i)
    
    %plot the earth sphere
    r_earth = c.r_earth;
    [x,y,z] = sphere;
    x = x*r_earth;
    y = y*r_earth;
    z = z*r_earth;
    surf(x,y,z,DisplayName='Earth') %Plot Earth
    
    if(~isempty(spacecraft))
        i = 1;
        j = 1;
        while (i < length(spacecraft))
            
            E_r = spacecraft(:,i);
            E_v = spacecraft(:,i+1);
            plot_spacecraft_orbit(E_r,E_v,j);
            j = j + 1;
            i = i + 2;
        end
    end
    if(~isempty(orbits))
        i = 1;
        j = 1;
        while (i<length(orbits))
            a = orbits(i);
            e = orbits(i+1);
            inc = orbits(i+2);
            plot_general_orbit(a,e,inc,j);
            j = j+1;
            i = i+3;
        end
    end
    axis equal
    title('Orbit')
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    legend();
    hold off
    
end