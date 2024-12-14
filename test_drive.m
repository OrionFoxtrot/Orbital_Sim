clear; clc;

E_r = [ 34205.52*10^3;
    -21532.42*10^3;
    -14872.82*10^3;
    ];
E_v = [ 2.970126*10^3;
    -0.22070*10^3;
    -1.291448*10^3;
    ];
orb_el = calculate_orbital_elements(E_r,E_v);
u_earth = 3.986004418e14
[R,V] = orbitalElementsToRV(orb_el,u_earth)


%%
orb_el = calculate_orbital_elements(E_r,E_v,[1;1;1])
coo = calculate_orbital_line(orb_el);

r_earth = 6.3781e6
close all
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;
% figure
% hold on

surf(x+650000,y+650000,z+650000)
hold on
plot3(E_r(1), E_r(2), E_r(3),'o','MarkerSize',20,'MarkerFaceColor','r')
plot3(coo.x,coo.y,coo.z)
axis equal
title('abc')

%%
clear; clc;
coo = general_orbit_line(10e6, 0, 0);

r_earth = 6.3781e6;
close all
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;
% figure
% hold on

surf(x,y,z)
hold on

plot3(coo.x,coo.y,coo.z)
axis equal
title('abc')
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');