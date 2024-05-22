% -------------------------------------------------------------------------
% This code written by Aslan Mohammadpour
% Email address: A.mohammadpourshoorbakhlou@imperial.ac.uk
%
% COPYRIGHT NOTICE:
% © 2024 Aslan Mohammadpour. All rights reserved.
%
% This code is the intellectual property of Aslan Mohammadpour.
% Unauthorized copying, sharing, distribution, or use of this code, 
% in whole or in part, is strictly prohibited without explicit permission 
% from the author, except as outlined below.
%
% PERMISSION NOTICE:
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this code, to use, copy, modify, and distribute the code, 
% provided that the original author is credited and this permission notice 
% is included in all copies or substantial portions of the code.
%
%
% DESCRIPTION:
% This code plots the resultant force generated in the circuits resulting 
% from open sections. It initializes parameters, calculates forces on the 
% main circuit and capacitors, and plots the average net force against 
% varying distances. for more please refer to the paper:
% Net Magnetic Force Generation in Discontinuous Circuits: A Force Symmetry-Breaking Phenomenon
%
O_prime = [0, 0.01, 0]; % coardinate of one side of open section
O = [0, 0, 0]; % coardinate of the other side of open section
I_A = 1000; % current in the main circuit in ampers
I_B = 1000; % current in the secondary circuit in ampers
distances = 0.01:0.001:0.1; % Varying distances from 0.01 to 0.5 meters
forces = zeros(size(distances)); % Initialize forces array

% capacitors dimensions and coardinates the force on one electrode of
% the capacitors are calculated and the force on the other electrod
% considered neglegible due to its distance 

O_center = [0, 0.0, 0];
R = 0.008;
a = 0.001;

% Loop over distances
for idx = 1:length(distances)
    d_0 = distances(idx);
    % the coardinates of two ends of a segment that is close to secondary wire
    % the other segments eaither cnacel each other force or produce neglegible
    % force on the main circuit
    A_start = [d_0, 0.000001, 0.10]; 
    A_end = [d_0, 0.000001, -0.10];
    % force on wire
    f_vec = calculateNetForce(d_0, A_start, A_end, O_prime, O, I_A, I_B);
    % force on capacitor
    F_AC = calculateForce_capacitor(A_start, A_end, O_center, R, a,  I_A, I_B);
    %force on the capacitor and the main circuit wires. Just the force on Z
    %direction is considered
    forces(idx) = f_vec(3)+ F_AC(3); 
end

% The force is proportianal to sin^2(omega t) but the average is half of the
% maximum force in its time period.  we need to multiply by 0.5 and again
% multiply by 2 because we have two secondary circuits at one side of 
% main circuit. We need to calculate the other side of circuit as can be
% seen in the paper. 
forces = 2 * forces; % there are two sections right and left 

%%
% Plotting
figure;
plot(distances*100, forces, 'LineWidth', 2, 'Color', 'b');
xlabel('Distance (cm)', 'FontSize', 18);
ylabel('Average Net Force (N)', 'FontSize', 18);
ax = gca; % Get current axes
ax.FontSize = 14; % Set tick mark font size
% title('Net Force vs. Distance');
xticks(0:1:10);
grid on;