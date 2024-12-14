clear; clc;
addpath("Plotting_Funs\");
c = constants();

E_r = [ 34205.52*10^3;
    -31532.42*10^3;
    -14872.82*10^3;
    ];
E_v = [ 2.970126*10^3;
    -0.22070*10^3;
    -1.291448*10^3;
    ];


r_earth = c.r_earth;

close all
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;

surf(x,y,z,DisplayName='Earth') %Plot Earth
hold on
plot_spacecraft_orbit(E_r,E_v)
plot_general_orbit(r_earth+1e7,0,0)
% legend()

axis equal
title('Orbit')
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
hold off