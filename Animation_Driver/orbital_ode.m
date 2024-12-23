function [E_rs, E_vs, t] = orbital_ode(E_r,E_v,time) 
    % Input's E_r (m), E_v (m/s), Time (hours)
    % Output's time series E_r using ode45 with acceleration (a) = c.
    c = constants();
    
    X0 = [E_r, E_v];
    
    % t = [0 time*60*60];
    t = 0:time*2:time*60*60;
    a = 0;
    
    fdynamic = @(t,X) orbital_step(t,X,a,c);
    options = odeset('RelTol',1e-6,'AbsTol',1e-9);
    [t,X] = ode45(fdynamic, t, X0, options);
    
    E_rs = X(:,1:3);
    E_vs = X(:,4:6);

end

% Input Args for ode45:
% [E_r, E_v]
% XDot = [E_v, E_a], E_a should probablly just be 0 for now for animation

function Xdot = orbital_step(t,X,a,c)
    % E_r_x = X(1);
    % E_r_y = X(2);
    % E_r_z = X(3);
    % 
    % E_v_x = X(4);
    % E_v_y = X(5);
    % E_v_z = X(6);

    E_r = X(1:3);
    E_v = X(4:6);


    v_dot = c.u_earth/norm(E_r)^2 .* -(E_r/norm(E_r));
    vx_dot = v_dot(1) + a;
    vy_dot = v_dot(2) + a;
    vz_dot = v_dot(3) + a;

    Xdot = [E_v; vx_dot; vy_dot; vz_dot];

end


%, ECI_x, ECI_y, ECI_z