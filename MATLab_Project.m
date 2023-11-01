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
T_high_water = 30; % Defining high inlet water temperature to 30C 
T_low_water = 10; % Defining low inlet water temperature to 10C
interval = 2; % Defining interval to 2C
% Defining inlet temperature from 10C to 30C in increments of 2C
T_in_water = T_low_water:interval:T_high_water;
T_out_water = 70; % Defining outlet temperature to 70C

% 1) Solving for enthalpy (h) for ethylene glycol
% Solving for enthalpy (h) using h = cp*deltaT = cp(T_out - T_in)
h_glycol = c_p_glycol * (T_out_glycol - T_in_glycol);
% Display results
fprintf("Therefore, the enthalpy (h) of ethylene glycol is %f\n", h_glycol)

% 2) Solving for saturated liquid water enthalpy (h_R)
h_R_low = 42.022; % Enthalpy values for Temperature 10C
h_R_high = 125.74; % Enthalpy values for Temperature 30C
counter = 0; % Intialize counter for the for loop
h_R_water = zeros(1); % Intialize results matrix for the for loop

% This for loop calculates the interpolated enthalphy values of water
for T_water_interpolated = T_in_water
  counter = counter + 1; % Add counter with 1
  % Calculating temperature interpolation factor from (mid - low)/(high - low)
  T_interpolation_factor = (T_water_interpolated - T_low_water) ...
                           /(T_high_water - T_low_water);
  % Interpolating for the enthalpy value (h)
  h = (h_R_high - h_R_low) * T_interpolation_factor + h_R_low;
  h_R_water(counter) = h; % Setting interpolated value to a matrix
end