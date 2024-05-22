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
function F_AB = calculateForce(A_start, A_end, O_prime, O, I_A, I_B)
    % Constants
    mu_0 = 4*pi*1e-7; % Permeability of free space
    
  
    % Function to calculate the integrand
    syms x;
    
    r_o_prime_vec=  A_start+x*(A_end-A_start)-O_prime;
    r_o_vec=  A_start+x*(A_end-A_start)-O;
    r_o_prime = sqrt((r_o_prime_vec(1))^2 + (r_o_prime_vec(2))^2 + (r_o_prime_vec(3))^2);
    r_o = sqrt((r_o_vec(1))^2 + (r_o_vec(2))^2 + (r_o_vec(3))^2);
    integrand =  (1/r_o_prime - 1/r_o);
                 
    % Perform the integral over x from 0 to 1 (parametrizing the line segment)
     integralValue = integral(matlabFunction(integrand), 0, 1, 'ArrayValued', true)*(A_end-A_start);
%        integralValue = int(integrand, 0, 1);
    % Calculate the net force using the given formula
    F_AB = (mu_0 * I_A * I_B / (4 * pi)) * integralValue;
end
