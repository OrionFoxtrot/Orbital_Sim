function [orbit_coords, orbital_line] = plot_spacecraft_orbit (E_r, E_v,num, plot_flag, varargin)

% If plotflag = 1; plot the stuff; if Plotflag = 0; Dont plot It
if(nargin <= 3)
    plot_flag = 1;
end
% plot_flag

orb_el = calculate_orbital_elements(E_r,E_v);
% orb_el.a
% orb_el.eccentricity_value
% orb_el.inclination
% orb_el.RAAN
% orb_el.argument
% orb_el.True_Anomoly

if (isnan(orb_el.RAAN))
    orb_el.RAAN = 0;
    orb_el.argument = 0;
end

coo = calculate_orbital_line(orb_el);

if(plot_flag)
    plot3(E_r(1), E_r(2), E_r(3),'o','MarkerSize',6,'MarkerFaceColor','r','HandleVisibility','off') %Plot Specific Spacecraft Location
    plot3(coo.x,coo.y,coo.z,'DisplayName',sprintf('Spacecraft Orbit %i',num)) %Plot specific spacecraft orbit
    % E_v = 10e3*E_v;
    % quiver3(E_r(1), E_r(2), E_r(3), E_v(1), E_v(2), E_v(3)) %Plot Velocity
    v1 = [0 0 0];
    v2 = [E_r(1), E_r(2), E_r(3)];
    v=[v2;v1];
    plot3(v(:,1),v(:,2),v(:,3),'HandleVisibility','off')
    % plot([0;E_r(1)],[0;E_r(2)],[0;E_r(3)],'HandleVisibility','off')
end

orbit_coords = E_r;
orbital_line = [coo.x', coo.y', coo.z'];
%'HandleVisibility','off'

end