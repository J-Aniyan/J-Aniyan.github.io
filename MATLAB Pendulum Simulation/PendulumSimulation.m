clear all;
close all;
clc;

%% Inputs (Initial Values)
prompt1 = 'input initial angular speed \n';
prompt2 = 'input initial position (theta in rad) \n';
prompt3 = 'input pendulum length (in metres) \n';
prompt4 = 'input gravitational acceleration \n';

omega(1) = input(prompt1); % initial value for angular speed
theta(1) = input(prompt2); % initial value for angle

time(1) = 0;               % initial time
dt = 0.01;                 % time step
steps = 1000;              % number of steps
L = input(prompt3);        % length in metres
g = input(prompt4);        % gravitational acceleration

%% Euler Method 2nd Derivative
for i = 2:steps            
     omega(i) = -(g/L)*sin(theta(i-1))*dt + omega(i-1);
     theta(i) = omega(i)*dt +theta(i-1);
     time(i) = time(i-1) + dt;
end

% Graph
plot(time,theta);
title('Simple Pendulum Motion');
xlabel('time / s');
ylabel('theta / rad');

%% finding period using signal processing toolbox add-on

[~,maxima] = findpeaks(theta);
gap = mean(diff(maxima));
period = gap*dt;

%% Saving data to excel spreadsheet

fileName = 'spreadsheet.xlsx';
labels = ["Time(s)","Theta(rad)","Omega(rad/s)","Period(s)","Gravitation attraction(m/s^2)","Length(m)"];

% Row to column vector
time_data = [time]';
theta_data = [theta]';
omega_data = [omega]';

% writing data to spreadsheet
writematrix(labels,fileName,'Sheet','Pendulum data','Range','A1:F1');           %column headings
writematrix(time_data,fileName,'Sheet','Pendulum data','Range','A2:A1001');     %time data
writematrix(theta_data,fileName,'Sheet','Pendulum data','Range','B2:B1001');    %theta data
writematrix(omega_data,fileName,'Sheet','Pendulum data','Range','C2:C1001');    %omega data
writematrix(period,fileName,'Sheet','Pendulum data','Range','D2');              %period value
writematrix(g,fileName,'Sheet','Pendulum data','Range','E2');                   %g value
writematrix(L,fileName,'Sheet','Pendulum data','Range','F2');                   %L value

fprintf('please check %s for full list of outputs \n',fileName);

























