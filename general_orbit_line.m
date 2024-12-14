function coor = general_orbit_line(a, e, i)
semi_major_axis = a; % Semi-major axis (in kilometers)
eccentricity = e;      % Orbital eccentricity
inclination = i;        % Inclination (in degrees)

% Convert inclination to radians
inclination_rad = deg2rad(inclination);

% Number of points for plotting
theta = linspace(0, 2*pi, 1000); % True anomaly from 0 to 360 degrees

% Parametric equations for the orbit in the orbital plane
r = semi_major_axis * (1 - eccentricity^2) ./ (1 + eccentricity * cos(theta)); % Orbital radius
x_orbital = r .* cos(theta); % X-coordinates in the orbital plane
y_orbital = r .* sin(theta); % Y-coordinates in the orbital plane
z_orbital = zeros(size(theta)); % Z-coordinates in the orbital plane (initially zero)

% Rotation matrix to account for inclination
rotation_matrix = [1, 0, 0;
    0, cos(inclination_rad), -sin(inclination_rad);
    0, sin(inclination_rad),  cos(inclination_rad)];

% Apply rotation to transform orbital plane to 3D space
orbit_3d = rotation_matrix * [x_orbital; y_orbital; z_orbital];
x_3d = orbit_3d(1, :);
y_3d = orbit_3d(2, :);
z_3d = orbit_3d(3, :);

coor = [];
coor.x = x_3d;
coor.y = y_3d;
coor.z = z_3d;
end
