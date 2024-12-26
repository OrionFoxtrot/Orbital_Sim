function flag = plot_earth_orbits(spacecrafts, orbits)
    % INPUTS:
    % spacecrafts : Spacecraft Definitions. Array. Series of [Spacecraft1,Spacecraft2,...]
    % orbits     : Orbital Definitions. Only consists of [[a,e,i],...]
    %              a - semi-major axis, e - eccentricity, i - inclination
    if(isempty(spacecrafts)&&isempty(orbits))
        disp('Both Spacecraft and Orbits Inputs Empty')
        return;
    end
    
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
    su = surf(x,y,z,DisplayName='Earth'); %Plot Earth
    set(su,'FaceColor',[0.3010 0.7450 0.9330],'FaceAlpha',1);

    
    if(~isempty(spacecrafts))
        for i = 1:length(spacecrafts)
            
            E_r = spacecrafts(i).E_r;
            E_v = spacecrafts(i).E_v;
            plot_spacecraft_orbit(E_r,E_v,i);
            
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