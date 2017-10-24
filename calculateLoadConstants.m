function  [k1, k2, k3]=calculateLoadConstants(accelPoints,torquePoints,timeStep)
% the function calculates the torque constants and the power for a given
% load case scenario

% calculate Load constants 
k1=sum(accelPoints.^2*timeStep)/(timeStep*length(accelPoints));
k2 = sum(torquePoints.^2*timeStep)/(timeStep*length(accelPoints));
k3 = sum(torquePoints.*accelPoints*timeStep)/(timeStep*length(accelPoints));



