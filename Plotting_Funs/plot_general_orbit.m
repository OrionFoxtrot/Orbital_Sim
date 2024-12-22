function plot_general_orbit (a,e,i,num) % PLOT A GENERAL ORBIT
    
    coo = general_orbit_line(a,e,i);
    plot3(coo.x,coo.y,coo.z,DisplayName=sprintf('General Orbit Line %i',num)) %Plot specific spacecraft orbit
end