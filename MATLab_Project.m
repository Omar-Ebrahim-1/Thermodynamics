% Name: Omar Ebrahim
% Student ID: 110076575
% Email: ebrahimo@uwindsor.ca
clear; clc;
% This section defines variables for ethylene glycol
c_p_glycol = 2.56; % Defining cp to 2.56 kJ/kg*C
m_dot_glycol = 3.2; % Defining flow rate of 3.2 kg/s
T_in_glycol = 80; % Defining inlet temperature to 80C
T_out_glycol = 40; % Defining outlet temperature to 40C

% This section defines variables for water
c_p_water = 4.18; % Defining cp to 4.18 kJ/kg*C
T_in_water = 10:2:30; % Defining inlet temperature from 10C to 30C in increments of 2C
T_out_water = 70; % Defining outlet temperature to 70C