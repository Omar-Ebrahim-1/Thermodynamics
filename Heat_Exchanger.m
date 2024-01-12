% Name: Omar Ebrahim
% Student ID: 110076575
% Email: ebrahimo@uwindsor.ca
clear; clc;

% This section defines variables for ethylene glycol
c_p_glycol = 2.56; % Defining cp to 2.56 kJ/kg*C
m_dot_glycol = 3.2; % Defining flow rate of 3.2 kg/s
T_in_glycol = 80; % Defining inlet temperature to 80C
T_out_glycol = 40; % Defining outlet temperature to 40C
h_glycol = c_p_glycol * (T_out_glycol - T_in_glycol); % Calculating enthalpy of glycol

% This section defines variables for water
c_p_water = 4.18; % Defining cp to 4.18 kJ/kg*C
T_water_10 = 10; % Defining water temperature at 10C
T_water_15 = 15; % Defining water temperature at 15C
T_water_20 = 20; % Defining water temperature at 20C
T_water_25 = 25; % Defining water temperature at 25C
T_water_30 = 30; % Defining water temperature at 30C
interval = 2; % Defining interval to 2C
% Defining inlet temperature from 10C to 30C in increments of 2C
T_in_water = T_water_10:interval:T_water_30;
T_out_water = 70; % Defining outlet temperature to 70C

% 1) Solving for enthalpy (h) for water analytically
% Solving for enthalpy (h) using h = cp*deltaT = cp(T_out - T_in)
counter = 0; % Intialize counter for the for loop
h_water_analytical = zeros(1); % Intialize results matrix for the for loop
for T_water_analytical = T_in_water
  counter = counter + 1; % Add counter with 1
  h = c_p_water * (T_out_water - T_water_analytical);
  h_water_analytical(counter) = h; % Setting enthalpy value to a matrix
end

% 2) Solving for saturated liquid water enthalpy (h_R) using interpolation
h_R_10 = 42.022; % Enthalpy values for Temperature 10C
h_R_15 = 62.982; % Enthalpy values for Temperature 15C
h_R_20 = 83.915; % Enthalpy values for Temperature 20C
h_R_25 = 104.83; % Enthalpy values for Temperature 25C
h_R_30 = 125.74; % Enthalpy values for Temperature 30C
h_R_70 = 293.07; % Enthalpy values for Temperature 70C
counter = 0; % Intialize counter for the for loop
h_R_water = zeros(1); % Intialize results matrix for the for loop

% This for loop calculates the interpolated enthalphy values of water
for T_water_interpolated = T_in_water
  counter = counter + 1; % Add counter with 1

  if T_water_interpolated == 10 % If temperature is 10C
    h = h_R_10; % Set enthalpy value to 42.022
    h_R_water(counter) = h; % Setting enthalpy value to a matrix
    continue % Skip to next iteration
  end

  % If temperature is between 10C and 15C
  if 10 < T_water_interpolated && T_water_interpolated < 15
    % Calculating temperature interpolation factor from (mid - low)/(high - low)
    T_interpolation_factor = (T_water_interpolated - T_water_10) ...
                             /(T_water_15 - T_water_10);
    % Interpolating for the enthalpy value (h)
    h = (h_R_15 - h_R_10) * T_interpolation_factor + h_R_10;
    h_R_water(counter) = h; % Setting interpolated value to a matrix
    continue % Skip to next iteration
  end

  % if temperature is between 15C and 20C
  if 15 < T_water_interpolated && T_water_interpolated < 20 % If temperature is 15C
    % Calculating temperature interpolation factor from (mid - low)/(high - low)
    T_interpolation_factor = (T_water_interpolated - T_water_15) ...
                             /(T_water_20 - T_water_15);
    % Interpolating for the enthalpy value (h)
    h = (h_R_20 - h_R_15) * T_interpolation_factor + h_R_15;
    h_R_water(counter) = h; % Setting interpolated value to a matrix
    continue % Skip to next iteration
  end

  if T_water_interpolated == 20 % If temperature is 20C
    h = h_R_20; % Set enthalpy value to 83.915
    h_R_water(counter) = h; % Setting enthalpy value to a matrix
    continue % Skip to next iteration
  end

  % if temperature is between 20C and 25C
  if 20 < T_water_interpolated && T_water_interpolated < 25 % If temperature is 15C
    % Calculating temperature interpolation factor from (mid - low)/(high - low)
    T_interpolation_factor = (T_water_interpolated - T_water_20) ...
                             /(T_water_25 - T_water_20);
    % Interpolating for the enthalpy value (h)
    h = (h_R_25 - h_R_20) * T_interpolation_factor + h_R_20;
    h_R_water(counter) = h; % Setting interpolated value to a matrix
    continue % Skip to next iteration
  end

  % if temperature is between 25C and 30C
   if 25 < T_water_interpolated && T_water_interpolated < 30 % If temperature is 15C
    % Calculating temperature interpolation factor from (mid - low)/(high - low)
    T_interpolation_factor = (T_water_interpolated - T_water_25) ...
                             /(T_water_30 - T_water_25);
    % Interpolating for the enthalpy value (h)
    h = (h_R_30 - h_R_25) * T_interpolation_factor + h_R_25;
    h_R_water(counter) = h; % Setting interpolated value to a matrix
    continue % Skip to next iteration
  end


  if T_water_interpolated == 30 % If temperature is 30C
    h = h_R_30; % Set enthalpy value to 125.74
    h_R_water(counter) = h; % Setting enthalpy value to a matrix
    continue % Skip to next iteration
  end
end

% Calculating the mass flow rate of water from analytical enthalpy
m_dot_water_analytical = -m_dot_glycol * h_glycol ./ h_water_analytical;
% Calculating the mass flow rate of water from interpolated enthalpy
m_dot_water_interpolated = m_dot_glycol * h_glycol ./ (h_R_water - h_R_70);

% Plotting inlet temperature vs mass flow rate of water
plot(T_in_water, m_dot_water_analytical, '-o'); % Plotting analytical values
hold on; % Hold on to plot the next graph
plot(T_in_water, m_dot_water_interpolated, '--s'); % Plotting interpolated values
hold off; % Turn off hold
title('Inlet Temperature vs Mass Flow Rate of Water'); % Setting title
xlabel('Inlet Temperature (C)'); % Setting x-axis label
ylabel('Mass Flow Rate of Water (kg/s)'); % Setting y-axis label
legend('Constant specific heat', 'Saturated liquid enthalpy'); % Setting legend
grid on; % Turning on grid

% Outputting data to a data ledger
fprintf(['\tInlet Temperature (C)  \t\t\tMass Flow Rate of Water Constant Specific ' ...
    'Heat (kg/s)  \t\tMass Flow Rate of Water Saturated Liquid Enthalpy (kg/s)\n']);
fprintf(['---------------------------------------------------------------------' ...
    '---------------------------------------------------------------' ...
    '----------------------------------------------\n']);
for i = 1:length(T_in_water)
  fprintf('%20d  %56.5f  %64.5f\n', T_in_water(i), m_dot_water_analytical(i), ...
          m_dot_water_interpolated(i));
end
