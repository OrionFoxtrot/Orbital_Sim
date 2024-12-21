function [R, V] = orbitalElementsToRV(p, mu) %GIVEN ORBITAL ELEMENTS, CONVERT THEM INTO E_R and E_V VECTORS OF A SPACECRAFT
% INPUTS:
% a      : Semi-major axis (m)
% e      : Eccentricity
% i      : Inclination (radians)
% RAAN   : Right Ascension of Ascending Node (radians)
% omega  : Argument of Periapsis (radians)
% nu     : True Anomaly (radians)
% mu     : Standard gravitational parameter (m^3/s^2)

a = p.a;
e = p.eccentricity_value;
i = deg2rad(p.inclination);
RAAN = deg2rad(p.RAAN);
omega = deg2rad(p.argument);
nu = deg2rad(p.True_Anomoly);


% Compute the orbital radius (r) and specific angular momentum (h)
p = a * (1 - e^2); % Semi-latus rectum
r = p / (1 + e * cos(nu)); % Orbital radius

% Position vector in PQW (perifocal frame)
r_PQW = [r * cos(nu); r * sin(nu); 0];

% Velocity vector in PQW (perifocal frame)
v_PQW = [ -sqrt(mu/p) * sin(nu);
    sqrt(mu/p) * (e + cos(nu));
    0 ];

% Transformation matrix from PQW to ECI
% Rotation matrix components
cos_Omega = cos(RAAN);
sin_Omega = sin(RAAN);
cos_omega = cos(omega);
sin_omega = sin(omega);
cos_i = cos(i);
sin_i = sin(i);

% Rotation matrix
Q = [ cos_Omega*cos_omega - sin_Omega*sin_omega*cos_i, -cos_Omega*sin_omega - sin_Omega*cos_omega*cos_i, sin_Omega*sin_i;
    sin_Omega*cos_omega + cos_Omega*sin_omega*cos_i, -sin_Omega*sin_omega + cos_Omega*cos_omega*cos_i, -cos_Omega*sin_i;
    sin_omega*sin_i,                              cos_omega*sin_i,                              cos_i ];

% Transform position and velocity vectors to ECI frame
R = Q * r_PQW; % Position in ECI
V = Q * v_PQW; % Velocity in ECI
end
