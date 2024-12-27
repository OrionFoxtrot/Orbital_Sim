function deltaV = orbit_circularization (Orbit_Current, planet)
    %   CIRCULARIZE A ECCENTRIC ORBIT (e<1e-3)
    %   INPUT:
    %   Orbit_Current: [E_r, E_v] Pair of Current Orbit
    %   Planet: Planet/celestial body currently being orbitted
    E_r_0 = Orbit_Current(:,1);
    E_v_0 = Orbit_Current(:,2);
    p = calculate_orbital_elements(E_r_0, E_v_0);
    if (p.eccentricity_value<1e-3)
        disp('Initial Orbit is Currently Circular')
        deltaV = 0;
        return
    end
    % https://en.wikipedia.org/wiki/Hohmann_transfer_orbit
        
    specific_c = constants(str(planet));
    [r,u,m] = deal(specific_c(1),specific_c(2),specific_c(3));

    % Apoapsis radius => r_a = a(1+e) (IN ECI)
    r_a = p.a * (1+p.eccentricity_value);
    
    % Apoapsis Velocity (Via Vis Viva) => v_a = (u * (2/r_a - 1/a)^1/2
    v_a = sqrt( u * (2/r_a - 1/a) );

    % V desired at apoapsis is when r_a = a; so 2/a - 1/a = 1/a;
    % So V_desired = sqrt( u/a )
    v_desired = sqrt(u/r_a);

    % Circularizing (Up) is always applied at appogee. And should be
    % applied Prograde.
    deltaV = v_desired - v_a; 
    
    if(deltaV<0)
        disp('this shoulnt happen. But if it does, know this has failed')
    end



end