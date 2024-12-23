classdef Spacecraft
    properties
        mass
        E_r
        E_v
    end
    methods        
        function obj = Spacecraft(m,r,v)
            c = constants();
            if nargin == 0
                obj.mass = 100; %100kg
                obj.E_r = c.Earth_GEO_Orbit.E_r; % E_r of GEO in 3x1
                obj.E_v = c.Earth_GEO_Orbit.E_v; % E_v of GEO in 3x1
            end
            if nargin == 1
                obj.mass = m;
                obj.E_r = c.Earth_GEO_Orbit.E_r; % E_r of GEO in 3x1
                obj.E_v = c.Earth_GEO_Orbit.E_v; % E_v of GEO in 3x1
            end
            if nargin == 3
                if (height(r) == 3 && width(v) == 1)
                    obj.mass = m;
                    obj.E_r = r; % E_r of custom in 3x1
                    obj.E_v = v; % E_v of custom in 3x1
                else
                    disp('Incorrect Dimentions of E_r or E_v, Requires 3x1 in form [x;y;z]')
                    disp('defaulting to GEO spacecraft of mass 100kg')
                    obj = Spacecraft();
                end
            end
        end
    end


end