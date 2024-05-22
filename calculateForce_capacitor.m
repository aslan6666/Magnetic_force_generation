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
function F_AB = calculateForce_capacitor(A_start, A_end, O_center, R, a,  I_A, I_B)
    % Constants
    mu_0 = 4*pi*1e-7; % Permeability of free space
    
    
    % Function to calculate the integrand
    syms x r_prime theta;
    
    r_prime_vec = [r_prime*cos(theta), 0 , r_prime*sin(theta)];
    % unit vector on the circular capacitor for different directions 
    r_prime_hat = [cos(theta), 0 , sin(theta)];
    % the r_vec is given parametrically. this defines the distance of 
    %  the capacitor from the secondary wire through parametric 
    % variable x
    r_vec=  O_center + r_prime_vec - (A_start+x*(A_end-A_start)) ;
    % this calculate the radial current desnisty
    J_r_prime = -0.5 * I_B / (pi*(R^2-a^2))* (r_prime - R^2/r_prime)  ; 
    % size of the r_vec
    r = sqrt((r_vec(1))^2 + (r_vec(2))^2 + (r_vec(3))^2);
    % calculating the dot product 
    r_vec_dot_r_prime_hat =  r_vec(1)* r_prime_hat(1) + ...
        r_vec(2)* r_prime_hat(2) + r_vec(3)* r_prime_hat(3);
  
    integrand = r_prime * J_r_prime * r_vec_dot_r_prime_hat/ r^3 ;
    
    % Convert symbolic expression to function handle
    f   = matlabFunction(integrand, 'Vars', [x, r_prime, theta]);
                 
    % Perform the integral over x from 0 to 1 (parametrizing the line segment)
    % Perform the integral over r_prim from a to R 
    % Perform the integral over theta angle from 0 to 2pi  
    integral_value = integral3(f, 0, 1, a, R, 0, 2*pi) *(A_end-A_start);
     

    % Calculate the net force using the given formula
    F_AB = (mu_0 * I_A  / (4 * pi)) * integral_value;
end
