function z = plot_spacecraft_orbit (E_r, E_v)

orb_el = calculate_orbital_elements(E_r,E_v);
orb_el.a
orb_el.eccentricity_value
orb_el.inclination
orb_el.RAAN
orb_el.argument
orb_el.True_Anomoly

if (isnan(orb_el.RAAN))
    orb_el.RAAN = 0;
    orb_el.argument = 0;
end

coo = calculate_orbital_line(orb_el);

plot3(E_r(1), E_r(2), E_r(3),'o','MarkerSize',6,'MarkerFaceColor','r','DisplayName','Spacecraft') %Plot Specific Spacecraft Location
plot3(coo.x,coo.y,coo.z,'DisplayName','Spacecraft Orbit') %Plot specific spacecraft orbit
% E_v = 10e3*E_v;
% quiver3(E_r(1), E_r(2), E_r(3), E_v(1), E_v(2), E_v(3)) %Plot Velocity
v1 = [0 0 0];
v2 = [E_r(1), E_r(2), E_r(3)];
v=[v2;v1];
plot3(v(:,1),v(:,2),v(:,3),'HandleVisibility','off')
% plot([0;E_r(1)],[0;E_r(2)],[0;E_r(3)],'HandleVisibility','off')


%'HandleVisibility','off'

end