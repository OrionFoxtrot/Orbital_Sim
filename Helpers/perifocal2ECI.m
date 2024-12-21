function e = perifocal2ECI(p, RAAN, i, argument)
    % Transform a vector from perifocal coordinates to equatorial coordinates
    %
    % Inputs:
    %   p, struct of Perifocal coordinates
    %   RAAN, Longitude of ascending node (radians)
    %   i, Inclination (radians)
    %   argument, Argument of perigee (radians)
    %
    % Outputs:
    %   x_equatorial, y_equatorial, z_equatorial - Equatorial coordinates

    % Define the transformation matrix
    R = [ cos(RAAN)*cos(argument) - sin(RAAN)*cos(i)*sin(argument), -cos(RAAN)*sin(argument) - sin(RAAN)*cos(i)*cos(argument), sin(RAAN)*sin(i);
          sin(RAAN)*cos(argument) + cos(RAAN)*cos(i)*sin(argument), -sin(RAAN)*sin(argument) + cos(RAAN)*cos(i)*cos(argument), -cos(RAAN)*sin(i);
          sin(i)*sin(argument),                                 sin(i)*cos(argument),                                cos(i)];
    
    % Input vector in perifocal coordinates
    r_perifocal = [p(1); p(2); p(3)];
    
    % Transform to equatorial coordinates
    r_equatorial = R * r_perifocal;
    
    % Extract components
    e.x = r_equatorial(1);
    e.y = r_equatorial(2);
    e.z = r_equatorial(3);
end
