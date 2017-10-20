function  [  test ]=selectMotor(accelPoints,torquePoints,timeStep)
% the function sizes the motor/gear combinations

%Constant
gearRatioResolution=0.1;


%load motor data
motors=getMotorData;

%load gear data
gears=getGearData;

[velocity,position,totalTime]=integrateAcceleration(accelPoints,timeStep);
%calculate matrix
loadRpmMax=max(velocity)*60/(2*pi);

%calculate Load constnats
[k1,k2,k3]=calculateLoadConstants(accelPoints,torquePoints,timeStep);


%calculate torque values
torqueLoadMax = max(abs(torqueLoad));
torqueLoadRMS = sqrt(k2);

%calculate power
powerLoad= torqueLoad.*velocity;
powerMean= norm(powerLoad,1)*length(powerLoad);
powerMax= max(powerLoad);

%make sure energy is positive

workTemp =powerLoad;
for idx=1:length(workTemp)
    if(workTemp(idx) < 0)
        workTemp(idx) = 0;
    end
end
    
workLoad = sum(workTemp*timeStep);


%calculate max gear ratio for motor-gear combinations
for idx=1:size(motors,2)
    maxGearRatio(idx) = round(1/gearRatioResolution*min(motors(6,idx), gears(1,idx)/MaxLRPM)*gearRatioResolution;
    gearRatioVector=[1:gearRatioResolution:maxGearRatio(idx)];
end;

for idx=1:size(gears,2)
    loadTorquePart=torquePoints.*velocity/gears(2,idx);
end

for idx=1:size(motors,2)
    for idx2=1:size(gears,2)
        torqueRMS(idx,:)=sqrt((motors(3,idx)+gears(2,idx2)
