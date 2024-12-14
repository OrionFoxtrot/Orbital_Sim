function plot_general_orbit (a,e,i) % PLOT A GENERAL ORBIT
    
    coo = general_orbit_line(a,e,i);
    plot3(coo.x,coo.y,coo.z,DisplayName='General Orbit Line') %Plot specific spacecraft orbit
end