clear; clc;
addpath("Plotting_Funs\");
addpath("Helpers\")
c = constants();

E_r = [ 34205.52*10^3;
    -31532.42*10^3;
    -14872.82*10^3;
    ];
E_v = [ 2.970126*10^3;
    -0.22070*10^3;
    -1.291448*10^3;
    ];

p = [];
p.a = 10e7;
p.eccentricity_value = 0;
p.inclination = 0;
p.RAAN = 100;
p.argument = 100; % Arg of Periapsis
p.True_Anomoly = 100;

% [E_r,E_v] = OrbitalElementsToRV2(p.a,p.eccentricity_value,p.inclination,p.RAAN,p.argument,p.True_Anomoly ...
    % ,c.u_earth);
[E_r,E_v] = orbitalElementsToRV(p,c.u_earth)



close all
r_earth = c.r_earth;
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;

surf(x,y,z,DisplayName='Earth') %Plot Earth
hold on
plot_spacecraft_orbit(E_r,E_v)
% plot_general_orbit(r_earth+1e7,0,0)
% plot3 ( [0;ecis.x],[0;ecis.y],[0;ecis.z] )
% legend()

axis equal
title('Orbit')
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
hold off