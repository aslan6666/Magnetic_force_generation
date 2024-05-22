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
function F_net = calculateNetForce(d_0, A_start, A_end, O_prime, O, I_A, I_B)
    % Assuming calculateForce is a function that calculates the force
    % based on the positions A_start, A_end, O_prime, O, and currents I_A, I_B.
    F_AB = calculateForce(A_start, A_end, O_prime, O, I_A, I_B);
    A_start(1) = 0.25; % Adjust starting position for second calculation
    A_end(1) = 0.25;   % Adjust ending position for second calculation
    F_AB_prim = -calculateForce(A_start, A_end, O_prime, O, I_A, I_B);
    F_net = F_AB + F_AB_prim;
end

