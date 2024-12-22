function t = Orbital_Time_Period(E_r,E_v,planet)
    c = constants();
    t = 0;
    if (planet == 'earth')
        p = calculate_orbital_elements(E_r,E_v);
        t = 2*pi*sqrt(p.a^3/(c.u_earth));
    end
end