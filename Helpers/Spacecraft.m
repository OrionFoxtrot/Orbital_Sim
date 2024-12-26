classdef Spacecraft
    % Spacecraft Class
    % Contains all state properties of a spacecraft orbitting around ECI
    properties
        mass
        E_r
        E_v

        % No Attitude Control

        % Still has 6 DOF
        % Radial In/Out R, -R
        % Prograde/Retrograde V, -V
        % Normal In/Out Cross(R,V), - Cross(R,V)

        radialIn 
        radialOut
        Prograde
        Retrograde
        Normal
        antiNormal

        p % Orbital Elements Struct
        a % Semi-Major Axis
        e % Eccentricity
        i % Inclination
        RAAN % Right Ascending Angle Node
        Argument % Argument
        True_Anomoly %True Anomoly

        circular_flag % Is orbit Circular? ie, e = 0?, if so RAAN and Arg Undefined. 


    end
    methods        
        function obj = Spacecraft(m,r,v)
            c = constants();
            if nargin == 0 % No Args
                obj.mass = 100; %100kg
                obj.E_r = c.Earth_GEO_Orbit.E_r; % E_r of GEO in 3x1
                obj.E_v = c.Earth_GEO_Orbit.E_v; % E_v of GEO in 3x1
            end
            if nargin == 1 % Only Mass Arg
                obj.mass = m;
                obj.E_r = c.Earth_GEO_Orbit.E_r; % E_r of GEO in 3x1
                obj.E_v = c.Earth_GEO_Orbit.E_v; % E_v of GEO in 3x1
            end
            if nargin == 3 % Mass and State Arg
                if (height(r) == 3 && width(v) == 1)
                    obj.mass = m;
                    obj.E_r = r; % E_r of custom in 3x1
                    obj.E_v = v; % E_v of custom in 3x1
                else
                    disp('Incorrect Dimentions of E_r or E_v, Requires 3x1 in form [x;y;z]')
                    disp('defaulting to GEO spacecraft of mass 100kg')
                    obj = Spacecraft();
                end
            end

            [obj.radialIn,obj.radialOut,obj.Prograde,obj.Retrograde, obj.Normal, obj.antiNormal] ...
                = calculate_directions(obj.E_r, obj.E_v);

            [obj.p,obj.a,obj.e,obj.i, obj.RAAN,obj.Argument, obj.True_Anomoly] ...
                = update_orb_elements(obj.E_r,obj.E_v);


        end
        function obj = update_Spacecraft(old_obj, new_r,new_v) 
            % Updates a old spacecraft class with a new E_r, E_v (possibly
            % related to previous Spacecraft) and updates directional
            % elements. 
            
            obj.E_r = new_r;
            obj.E_v = new_v;
            [obj.RadialIn,obj.RadialOut,obj.Prograde,obj.Retrograde, obj.Normal, obj.AntiNormal] ...
                = calculate_directions(obj.E_r, obj.E_v);

            [obj.p,obj.a,obj.e,obj.i, obj.RAAN,obj.Argument, obj.True_Anomoly] ...
                = update_orb_elements(obj.E_r,obj.E_v);

        end

        function debug_plot(spacecraft)
            % Just a Debug Function to Visualize the Locations of Stuff. 
            close all
            c = constants();
            hold on
            s_x = spacecraft.E_r(1);
            s_y = spacecraft.E_r(2);
            s_z = spacecraft.E_r(3);

            [~, coo] = plot_spacecraft_orbit(spacecraft.E_r,spacecraft.E_v,0,0);
            plot3(coo(:,1),coo(:,2),coo(:,3));

            plot3(s_x,s_y,s_z,...
                'o','MarkerSize',6,'MarkerFaceColor','g','color','g') % Plot the craft

            r_earth = c.r_earth;
            [x,y,z] = sphere;
            x = x*r_earth;
            y = y*r_earth;
            z = z*r_earth;
            surf(x,y,z,DisplayName='Earth') %Plot the Earth
            
            ScalingK = 5e7; %Scaling for the matlab quiver cuz the matlab quiver sucks
            spacecraft.Normal = spacecraft.Normal.*ScalingK;
            spacecraft.Prograde = spacecraft.Prograde.*ScalingK;
            spacecraft.radialIn = spacecraft.radialIn.*ScalingK;

            h1 = quiver3(s_x,s_y,s_z,spacecraft.Normal(1),spacecraft.Normal(2),spacecraft.Normal(3),"DisplayName","Normal");
            h2 = quiver3(s_x,s_y,s_z,spacecraft.Prograde(1),spacecraft.Prograde(2),spacecraft.Prograde(3),"DisplayName","Prograde");
            h3 = quiver3(s_x,s_y,s_z,spacecraft.radialIn(1),spacecraft.radialIn(2),spacecraft.radialIn(3),"DisplayName","RadialIn");
            legend([h1,h2,h3])
            hold off

        end
    end


end


function [p,a,e,i,raan,arg,true] = update_orb_elements(E_r,E_v)
    pl = calculate_orbital_elements(E_r,E_v);
    p = pl;
    a = pl.a;
    e = pl.eccentricity_value;
    i = pl.inclination;
    raan = pl.RAAN;
    arg = pl.argument;
    true = pl.True_Anomoly;
end

function [RadialIn,RadialOut,Prograde,Retrograde,Normal,AntiNormal] = ...
    calculate_directions(R,V)
    % Calculates 6 DOF of spacecraft. 

    RadialIn = -R/norm(R);
    RadialOut = -RadialIn;
    Prograde = V/norm(V);
    Retrograde = -Prograde;
    Normal = cross(R,V)/norm(cross(R,V)); %Is the Normal or AntiNormal? Not SUre 
    %TODO:
    %Figure this out. 
    AntiNormal = -Normal;

end