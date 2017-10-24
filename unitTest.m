clear all
clc
% roos original acceleration data
timeStep=0.01;
inertiaLoad=0.4;
accelerationValue=20;
accelPoints(1:20) = 0;
accelPoints(21:30) = accelerationValue;
accelPoints(31:40) = -accelerationValue;
accelPoints(41:60) = 0;
accelPoints(61:70) = -accelerationValue;
accelPoints(71:80) = accelerationValue;
accelPoints(81:120) = 0;
accelPoints(121:130) = -accelerationValue;
accelPoints(131:140) = accelerationValue;
accelPoints(141:160) = 0;
accelPoints(161:170) = accelerationValue;
accelPoints(171:180) = -accelerationValue;
accelPoints(181:201) = 0;

%Roos original torque data
[velocity, position]=integrateAcceleration(accelPoints,timeStep);
torquePoints=inertiaLoad*accelPoints;



[  torqueRMS  ,torqueLoadRMS ,torquePeak ,torqueLoadMax, powerLoadMax, powerMax, energy,workLoad, motorName,gearbox   ]=selectMotor(accelPoints,torquePoints,timeStep);

plotSelection(torqueRMS,torqueLoadRMS,torquePeak, torqueLoadMax, powerLoadMax ,powerMax, energy,workLoad,gearbox,motorName);


