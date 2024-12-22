clear; clc; close all;
addpath('C:\Users\lohat\OneDrive\Desktop\School\Cornell\MAE 5065 Intro to Spaceflight Mechanics\Orbital_Sim')
c = constants();

E_r = [ 34205.52*10^3;
    -31532.42*10^3;
    -14872.82*10^3;
    ];
E_v = [ 2.970126*10^3;
    -0.22070*10^3;
    -1.291448*10^3;
    ];

one_time_period = Orbital_Time_Period(E_r,E_v,'earth')/60/60;
[E_rs,E_vs] = orbital_ode(E_r, E_v, 50);


r_earth = c.r_earth;
[x,y,z] = sphere;
x = x*r_earth;
y = y*r_earth;
z = z*r_earth;

hold on
surf(x,y,z,DisplayName='Earth') %Plot Earth
pause()
for i = 1:length(E_rs)
    [E_cord, E_line] = plot_spacecraft_orbit(E_rs(i,:)', E_vs(i,:)',1,0);
    h1 = plot3(E_cord(1), E_cord(2), E_cord(3), ...
        'o','MarkerSize',6,'MarkerFaceColor','g','color','g');
    h2 = plot3(E_line(:,1),E_line(:,2), E_line(:,3),'color','r');
    
    pause(0.1)
    if(i == length(E_rs))
        break
    end
    delete(h1)
end
hold off
