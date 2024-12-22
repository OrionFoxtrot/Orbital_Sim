function [E_rs, E_vs] = orbital_ode(E_r,E_v,time) 
    % Input's E_r (m), E_v (m/s), Time (hours)
    % Output's time series E_r using ode45 with acceleration (a) = c.
    c = constants();
    
    X0 = [E_r, E_v];
    
    t = [0 time*60*60];
    a = 0;
    
    fdynamic = @(t,X) orbital_step(t,X,a,c);
    [t,X] = ode45(fdynamic, t, X0);
    
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

    Xdot = [E_v; v_dot];

end