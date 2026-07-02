%% PROJECT 1
% EV Motor Speed Control using MATLAB
%
% Description:
% This project models a DC motor and analyses its performance
% using Open Loop, Manual PID and MATLAB Tuned PID controllers.

clc;
clear;
close all;

disp("EV Motor Speed Control");

%% Motor Parameters

J = 0.01;
b = 0.1;
K = 0.01;

%% Transfer Function

num = K;
den = [J b];

motor = tf(num,den);

%% Open Loop Analysis

OpenLoopInfo = stepinfo(motor);

disp("Open Loop Characteristics")
disp(OpenLoopInfo)

disp("Open Loop Pole")
disp(pole(motor))

disp("Open Loop DC Gain")
disp(dcgain(motor))

%% Manual PID Controller

Kp = 5;
Ki = 10;
Kd = 0.5;

manualController = pid(Kp,Ki,Kd);

manualLoop = feedback(manualController*motor,1);

ManualInfo = stepinfo(manualLoop);

disp("Manual PID Characteristics")
disp(ManualInfo)

%% MATLAB Tuned PID Controller

tunedController = pidtune(motor,'PID');

disp("MATLAB Tuned PID Controller")
disp(tunedController)

tunedLoop = feedback(tunedController*motor,1);

TunedInfo = stepinfo(tunedLoop);

disp("MATLAB Tuned PID Characteristics")
disp(TunedInfo)

disp("Closed Loop DC Gain")
disp(dcgain(tunedLoop))

%% Step Response Comparison

figure

step(motor)
hold on
step(manualLoop)
step(tunedLoop)

grid on

title("Step Response Comparison")
xlabel("Time (seconds)")
ylabel("Angular Speed")

legend("Open Loop","Manual PID","MATLAB Tuned PID")
saveas(gcf,'Images/Step_Response_Comparison.png')

%% Pole Zero Map

figure

pzmap(motor)

grid on

title("Pole Zero Map")
saveas(gcf,'Images/Pole_Zero_Map.png')

%% Root Locus

figure

rlocus(motor)

grid on

title("Root Locus")
saveas(gcf,'Images/Root_Locus.png')

%% Bode Plot

figure

bode(motor)

grid on

title("Bode Plot")
saveas(gcf,'Images/Bode_Plot.png')

%% Gain Margin and Phase Margin

figure

margin(motor)

grid on

title("Gain Margin and Phase Margin")
saveas(gcf,'Images/Gain_Phase_Margin.png')

%% Nyquist Plot

figure

nyquist(motor)

grid on

title("Nyquist Plot")
saveas(gcf,'Images/Nyquist_Plot.png')