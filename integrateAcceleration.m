function [velocity,position]=integrateAcceleration(accelPoints,timeStep)
%This function integrates a given Acceleration value vector to get
%velocities and position
%   Inputs:
%   accelPoints: row vector of accelerations
%   timeStep: time step between acceleration points
velocity=zeros(1,length(accelPoints));
position=zeros(1,length(accelPoints));

velocity(1)=accelPoints(1)*timeStep;
position(1)=velocity(1)*timeStep;
    for idx=1:length(accelPoints)-1
        velocity(idx+1)=velocity(idx)+accelPoints(idx+1)*timeStep;
        position(idx+1)=position(idx)+velocity(idx+1);
    end
