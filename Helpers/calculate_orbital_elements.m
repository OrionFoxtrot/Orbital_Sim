function orb = calculate_orbital_elements(varargin)
    c = constants();
    u_earth = c.u_earth;
    if nargin == 2
        R = varargin(1);
        V = varargin(2);
        % Inputs: E_r, E_v, H
        % E_r = ECI R vector of craft
        % E_v = ECI V vector of craft
        % H =
        
        E_r = R{1};
        E_v = V{1};

        E_h = cross(E_r, E_v);
    
        orb = [];
        orb.inclination = rad2deg(acos(E_h' * [0;0;1]/ norm(E_h)));
    
        orb.eccentricity_vector = (1/u_earth * cross(E_v, E_h) ) - E_r/norm(E_r);
        orb.eccentricity_value = norm(orb.eccentricity_vector) ;
    
        orb.True_Anomoly = acos( ( dot(E_r,orb.eccentricity_vector) ) / (norm(E_r)*orb.eccentricity_value));
        orb.True_Anomoly = rad2deg(orb.True_Anomoly);
        orb.a = norm(E_r) * ( (1+orb.eccentricity_value*cos(deg2rad(orb.True_Anomoly))) / (1-orb.eccentricity_value^2) );
        orb.E_n = cross( [0;0;1], E_h );
        orb.argument = acos( dot(orb.E_n, orb.eccentricity_vector) / (norm(orb.E_n)*orb.eccentricity_value) );
        orb.argument = rad2deg(orb.argument);
        orb.RAAN = rad2deg( acos( dot(orb.E_n, [1;0;0])/ norm(orb.E_n)) );
    end
    
    if nargin == 3
        R = varargin(1);
        V = varargin(2);
        H = varargin(3);
        % Inputs: E_r, E_v, H
        % E_r = ECI R vector of craft
        % E_v = ECI V vector of craft
        % H = Angular Momentum of craft
        E_r = R{1};
        E_v = V{1};
        H = H{1};
        if(height(H) ~= 3)
            disp("H must be 3 row x 1 Col Vec")
            return
        end
        E_h = cross(E_r, E_v)+H;
     

    
        orb = [];
        orb.inclination = rad2deg(acos(E_h' * [0;0;1]/ norm(E_h)));
    
        orb.eccentricity_vector = (1/u_earth * cross(E_v, E_h) ) - E_r/norm(E_r);
        orb.eccentricity_value = norm(orb.eccentricity_vector) ;
    
        orb.True_Anomoly = acos( ( dot(E_r,orb.eccentricity_vector) ) / (norm(E_r)*orb.eccentricity_value));
        orb.True_Anomoly = rad2deg(orb.True_Anomoly);
        orb.a = norm(E_r) * ( (1+orb.eccentricity_value*cos(deg2rad(orb.True_Anomoly))) / (1-orb.eccentricity_value^2) );
        orb.E_n = cross( [0;0;1], E_h );
        orb.argument = acos( dot(orb.E_n, orb.eccentricity_vector) / (norm(orb.E_n)*orb.eccentricity_value) );
        orb.argument = rad2deg(orb.argument);
        orb.RAAN = rad2deg( acos( dot(orb.E_n, [1;0;0])/ norm(orb.E_n)) );
    end

end


