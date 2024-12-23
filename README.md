# Orbital Simulation Tools

Welcome to the **Orbital Simulation Tool**! This project is a comprehensive simulation framework designed for analyzing and visualizing orbital mechanics. Whether you're a student, researcher, or space enthusiast, this toolkit offers powerful tools to model spacecraft trajectories, calculate orbital parameters, and create visualizations of orbits.

## Features

- **Dynamic Animations**: Bring your simulations to life with smooth orbital animations.
- **Customizable Plots**: Generate detailed visualizations of spacecraft trajectories and orbital paths.
- **Helper Functions**: Easily convert between orbital elements and state vectors, calculate orbital periods, and more.
- **Modular Design**: Organized into intuitive components for easy expansion and integration.

## Use Cases

- **Educational Demonstrations**: Illustrate complex orbital concepts with interactive animations and plots.
- **Mission Planning**: Simulate spacecraft orbits to test mission feasibility.
- **Research and Development**: Analyze and predict orbital behaviors for academic or industrial purposes.

## Usage

To get started with the Orbital Simulation Tools, follow these simple steps:

### Prerequisites
Ensure you have the following installed:
- **MATLAB**: This project is built in MATLAB, so you'll need it to run the scripts.

### Instructions
- Clone the direction and open the main folder Orbital_Sim in Matlab
- Select the folders *Animation_Driver*, *Helpers* and *Plotting_Funs* in the Current Folder tab in Matlab, Right click it and add the folders to the Path.

### Basic Example
This basic example defines two spacecraft with two orbits and one general orbit. One eccentric orbit defined by location and velocity of a spacecraft, and another circular orbit defined by the 6 orbital parameters (Semi-Major Axis, Eccentricity, Inclination, RAAN, Argument, and the True Anomoly). The general orbit is one with no spacecraft defined, and this is defined by a semi-major axis, eccentricity and inclination. Then I plot these orbits. This sample is included as test_drive.m 
```
% Define initial position and velocity vectors
E_r_0 = [ 34205.52*10^3;
          -31532.42*10^3;
          -14872.82*10^3;
        ];
E_v_0 = [ 2.970126*10^3;
          -0.22070*10^3;
          -1.291448*10^3;
        ];

% Define orbital parameters
p = [];
p.a = 10e7;
p.eccentricity_value = 0;
p.inclination = 0;
p.RAAN = 100; % Right Ascension of Ascending Node
p.argument = 100; % Argument of Periapsis
p.True_Anomoly = 100;

% Convert orbital elements to position and velocity vectors
[E_r, E_v] = orbitalElementsToRV(p, c.u_earth);

% Create test state arrays
s_test1 = [[E_r, E_v], [E_r_0, E_v_0]];

% Define modified orbital parameters for plotting
o_test1 = [p.a - 5e7, p.eccentricity_value, p.inclination + 30];

% Plot the orbits (Statically)
plot_earth_orbits(s_test1, o_test1, c);

% OR Animate the Orbits using the following line, Comment out the line before this. 
% animate_earth_orbits(s_test1);
```

