function coords = calculate_orbital_line(orb_el) %Given 6 ORBITAL ELEMENTS, CALCULATE the 3D LINE THE ORBIT LIES UPON

% Orbital elements
a = orb_el.a;          % Semi-major axis in km
e = orb_el.eccentricity_value;          % Eccentricity
i = deg2rad(orb_el.inclination);   % Inclination in radians
Omega = deg2rad(orb_el.RAAN); % Longitude of ascending node in radians
omega = deg2rad(orb_el.argument); % Argument of periapsis in radians

% Number of points to calculate
n_points = 500;

% True anomaly range (0 to 2*pi)
nu = linspace(0, 2*pi, n_points);

% Calculate the radius for each true anomaly
r = a * (1 - e^2) ./ (1 + e * cos(nu));

% Perifocal (PQW) coordinates
x_p = r .* cos(nu);
y_p = r .* sin(nu);
z_p = zeros(size(nu));

% Rotation matrices
R_Omega = [
    cos(Omega), -sin(Omega), 0;
    sin(Omega),  cos(Omega), 0;
    0,          0,          1
    ];

R_i = [
    1,  0,           0;
    0,  cos(i), -sin(i);
    0,  sin(i),  cos(i)
    ];

R_omega = [
    cos(omega), -sin(omega), 0;
    sin(omega),  cos(omega), 0;
    0,          0,          1
    ];

% Combined rotation matrix
R_total = R_Omega * R_i * R_omega;

% Transform perifocal coordinates to geocentric equatorial frame
positions = R_total * [x_p; y_p; z_p];

% Extract x, y, z in the geocentric equatorial frame
x = positions(1, :);
y = positions(2, :);
z = positions(3, :);

% r_periapsis = orb_el.a * (1-orb_el.eccentricity_value)
% 6378100 - r_periapsis
p.x = x;
p.y = y;
p.z = z;
coords = p;


end