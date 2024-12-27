function deltaV = Hohmann_Transfer(Orbit_Current, Orbit_Desired, planet)
    %   HOHMANN ORBIT TRANSFER FOR TWO CIRCULAR ORBITS
    %   INPUT:
    %   Orbit_Current: [E_r, E_v] Pair of Current Orbit
    %   Orbit_Desired: A Desired [E_r]
    %   Planet: Planet/celestial body currently being orbitted
    E_r_0 = Orbit_Current(:,1);
    E_v_0 = Orbit_Current(:,2);
    p = calculate_orbital_elements(E_r_0, E_v_0);
    if ~(p.eccentricity_value<1e-3)
        disp('Initial Orbit is Non-Circular')
        deltaV = NaN;
        return
    end



end