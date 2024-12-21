function [E_r, E_v] = orbitalElementsToRV2(a, e, i, RAAN, argument, True_Anomoly, mu)
    % Depreciate, Only used for debug. 

    % Convert Deg To Rad
    i = deg2rad(i);
    RAAN = deg2rad(RAAN);
    argument = deg2rad(argument);
    True_Anomoly = deg2rad(True_Anomoly);

    % Compute the semi-latus rectum
    p = a*(1 - e^2);

    % Position and velocity in the perifocal (orbital) frame
    r_pf = (p / (1 + e*cos(True_Anomoly))) * [cos(True_Anomoly); sin(True_Anomoly); 0];
    v_pf = sqrt(mu / p) * [-sin(True_Anomoly); e + cos(True_Anomoly); 0];

    % Rotation from perifocal frame to ECI frame
    cO = cos(RAAN);
    sO = sin(RAAN);
    ci = cos(i);
    si = sin(i);
    co = cos(argument);
    so = sin(argument);

    % Perifocal to ECI rotation matrix
    RzOmega  = [ cO  sO  0
                -sO  cO  0
                 0    0  1];

    RxI = [1   0    0
           0   ci  -si
           0   si   ci];

    Rzomega = [  co   so   0
                -so   co   0
                 0     0   1];

    % From orbital frame to ECI: Q = Rz(-Omega)*Rx(-i)*Rz(-omega).
    Q = RzOmega.' * RxI.' * Rzomega.';

    % Transform position and velocity to ECI
    E_r = Q*r_pf;
    E_v = Q*v_pf;
end
