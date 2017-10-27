clear all
clc
% roos original acceleration data
timeStep=0.01;
inertiaLoad=0.012;
torqueFriction=7.5;
Acc=350;
accelPoints(1:40) = 0;
accelPoints(51:70) = Acc;
accelPoints(71:100) = 0;
accelPoints(101:120) = -Acc;
accelPoints(121:160) = 0;
accelPoints(161:180) = -Acc;
accelPoints(181:210) = 0;
accelPoints(211:230) = Acc;
accelPoints(231:300) = 0;
accelPoints(301:320) = -Acc;
accelPoints(321:330) = 0;
accelPoints(331:350) = Acc;
accelPoints(351:390) = 0;
accelPoints(391:410) = +Acc;
accelPoints(411:420) = 0;
accelPoints(421:440) = -Acc;
accelPoints(441:501) = 0;

%Roos original torque data
[velocity, position]=integrateAcceleration(accelPoints,timeStep);
torquePoints=sign(velocity).*torqueFriction+inertiaLoad*accelPoints+7.5;



[  torqueRMS  ,torqueLoadRMS ,torquePeak ,torqueLoadMax, powerLoadMax, powerMax, energy,workLoad, motorName,gearbox   ]=selectMotor(accelPoints,torquePoints,timeStep);

plotSelection(torqueRMS,torqueLoadRMS,torquePeak, torqueLoadMax, powerLoadMax ,powerMax, energy,workLoad,gearbox,motorName);


