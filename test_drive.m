clear; clc;
addpath("Plotting_Funs\");
addpath("Helpers\")
c = constants();

E_r_0 = [ 34205.52*10^3;
    -31532.42*10^3;
    -14872.82*10^3;
    ];
E_v_0 = [ 2.970126*10^3;
    -0.22070*10^3;
    -1.291448*10^3;
    ];

p = [];
p.a = 10e7;
p.eccentricity_value = 0;
p.inclination = 0.5;
p.RAAN = 100;
p.argument = 100; % Arg of Periapsis
p.True_Anomoly = 100;

% [E_r,E_v] = OrbitalElementsToRV2(p.a,p.eccentricity_value,p.inclination,p.RAAN,p.argument,p.True_Anomoly ...
    % ,c.u_earth);
[E_r,E_v] = orbitalElementsToRV(p,c.u_earth);


r_earth = c.r_earth;
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;

% Animation Driver:

hold on
axis equal
surf(x,y,z,DisplayName='Earth') %Plot Earth
plot_spacecraft_orbit(E_r,E_v,0,1)

hold off
%%
s_test1 = [[E_r,E_v],[E_r_0,E_v_0]];
s_test2 = [[E_r,E_v]];

o_test1 = [p.a-5e7,p.eccentricity_value,p.inclination+30];
% plot_earth_orbits(s_test1,o_test1,c)
animate_earth_orbits(s_test1)


%%
clear; clc;
addpath("Plotting_Funs\");
addpath("Helpers\")
c = constants();

p = [];
p.a = 42164e3;
p.eccentricity_value = 0;
p.inclination = 0;
p.RAAN = 100;
p.argument = 100; % Arg of Periapsis
p.True_Anomoly = 100;

[E_r,E_v] = orbitalElementsToRV(p,c.u_earth)

plot_earth_orbits([E_r,E_v],[],c)