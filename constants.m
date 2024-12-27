function const = constants(inspect, varargin)

   
    % Define planetary masses in kg
    const.m_moon = 7.34767309e22;
    const.m_mercury = 0.330e24;
    const.m_venus = 4.87e24;
    const.m_earth = 5.97e24;
    const.m_moon = 0.073e24;
    const.m_mars = 0.642e24;
    const.m_jupiter = 1898e24;
    const.m_saturn = 568e24;
    const.m_uranus = 86.8e24;
    const.m_neptune = 102e24;
    const.m_pluto = 0.0130e24;
    
    % Gravitational Constants
    const.u_sun = 1.32712440018e20;
    const.u_mercury = 2.20320e13;
    const.u_venus = 3.24858592e14;
    const.u_earth = 3.986004418e14;
    const.u_moon = 4.9048695e12;
    const.u_mars = 4.282837e13;
    const.u_ceres = 6.26325e10;
    const.u_jupiter = 1.26686534e17;
    const.u_saturn = 3.7931187e16;
    const.u_uranus = 5.793939e15;
    const.u_neptune = 6.836529e15;
    const.u_pluto = 8.71e11;
    const.u_eris = 1.108e12;
    
    % Radii
    const.r_mercury = 2440000;
    const.r_venus = 6052000;
    const.r_earth = 6371000;
    const.r_mars = 3390000;
    const.r_jupiter = 69911000;
    const.r_saturn = 58232000;
    const.r_uranus = 25362000;
    const.r_neptune = 24622000;
    const.r_moon = 1737.4e3;
    
    % Moon Orbit
    m = [];
    m.a = 0.3844e9;
    m.eccentricity_value = 0.0549;
    m.inclination = (18.28 + 28.58)/2;
    m.RAAN = 60;
    m.argument = 60;
    m.True_Anomoly = 60;
    const.Moon_Orbit = [];
    [const.Moon_Orbit.E_r, const.Moon_Orbit.E_v] = orbitalElementsToRV(m,const.u_earth);
    
    % Circular Earth Orbit
    Circular_orb_E_r = 1.0e+07*[2.1082;-3.6515;0];
    Circular_orb_E_v = 1.0e+03*[2.6627;1.5373;0];
    const.Earth_GEO_Orbit = [];
    const.Earth_GEO_Orbit.E_r = Circular_orb_E_r;
    const.Earth_GEO_Orbit.E_v = Circular_orb_E_v;
    
    if(nargin == 1)
        if(strcmp(inspect,'earth'))
            const = [const.r_earth, const.u_earth, const.m_earth];
        end
        if(strcmp(inspect,'moon'))
            const = [const.r_moon, const.u_moon, const.m_moon];
        end
        
    end




end

