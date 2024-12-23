function flag = animate_earth_orbits(spacecraft)
    % INPUTS:
    % spacecraft : Spacecraft Definitions. Array. Series of [[E_r,E_v],...]
    close all
    hold on
    c = constants();
    
    orbital_periods = [];
    % Calculate Orbital Periods
    if(~isempty(spacecraft))
        i = 1;
      
        while (i < length(spacecraft))
            
            E_r = spacecraft(:,i);
            E_v = spacecraft(:,i+1);
            one_time_period = Orbital_Time_Period(E_r,E_v,'earth')/60/60;
            orbital_periods = [orbital_periods, one_time_period];
            i = i + 2;
        end
    end

    E_rs = [];
    E_vs = [];
    t = [];

    if(~isempty(spacecraft))
        i = 1;
        j = 1;
        while (i < length(spacecraft))
            
            E_r = spacecraft(:,i);
            E_v = spacecraft(:,i+1);

            [E_rn,E_vn, tn] = orbital_ode(E_r, E_v, max(orbital_periods));

            E_rs = [E_rs, E_rn];
            E_vs = [E_vs, E_vn];
            t = [t, tn];
            
            j = j + 1;
            i = i + 2;
        end
    end
 
    
    %Calculate the earth sphere
    r_earth = c.r_earth;
    [x,y,z] = sphere;
    x = x*r_earth;
    y = y*r_earth;
    z = z*r_earth;

    % Animation Driver:
    
    hold on
    surf(x,y,z,DisplayName='Earth') %Plot Earth
    % view([11 30])
    pause()
    for i = 1:height(E_rs)
        title(sprintf(['Orbital Motion at Time %0.1f hours of total orbital' ...
            ' simulation time %0.1f'],t(i,1)/60/60,max(orbital_periods)))
        h = [];
        j = 1;
        k = 1;
        while k <= length(spacecraft)/2
           
            
            E_r = E_rs(:,j:j+2);
            E_v = E_vs(:,j:j+2);

            [E_cord, E_line] = plot_spacecraft_orbit(E_r(i,:)', E_v(i,:)',1,0);
            z1 = plot3(E_cord(1), E_cord(2), E_cord(3), ...
                'o','MarkerSize',6,'MarkerFaceColor','g','color','g');
            z2 = plot3(E_line(:,1),E_line(:,2), E_line(:,3),'color','r');
                
            z3 = text(E_cord(1), E_cord(2), E_cord(3),sprintf('Spacecraft %d',k));

            h = [h, z1, z2, z3];
            j = j+3;
            k = k+1;
        end
        if(i == height(E_rs))
            break
        end
        pause(0.1);
        delete(h);
    end
    hold off
    axis equal
    title('Orbit')
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
    hold off
    
end