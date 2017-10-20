function  [  test ]=selectMotor(accelPoints,torquePoints,timeStep)
% the function sizes the motor/gear combinations

%Constant
gearRatioResolution=0.1;


%load motor data
motors=getMotorData;

%load gear data
[gearData,teeth]=getGearData;
gearbox=calculateGearboxInertia;

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
    maxGearRatio(idx) = round(1/gearRatioResolution*min(motors(6,idx), max(gears(1,idx))/min(gears(1,idx)/MaxLRPM)*gearRatioResolution;
    gearRatioVector=[1:gearRatioResolution:maxGearRatio(idx)];
end

%calculate load torque part CP
for idx=1:size(gears,2)
    loadTorquePart=torquePoints.*velocity/gears(2,idx);
end

%calculate required RMS torque
for idx=1:size(motors,2)
    for idx2=1:size(gearbox,2)
        torqueRMS(idx,:)=   sqrt((motors(3,idx)+gearbox(1,idx2)^2*gearbox(1,idx2)^2*k1
                            +1/(gearbox(1,idx2)^2*gearData(2,1)^2)*k2
                            +2*((motors(3,idx)+gearbox(1,idx2))/gearData(2,1)*k3);
                            
        if torqueRMS(idx,idx2)>motors(3,idx)
            torqueRMS(idx,idx2)= NaN;
            torquePeak(idx,idx2)=NaN;
            powerMax(idx,idx2)=NaN;
            work(idx,idx2)=NaN;
        else
            torqueInstant=(motors(3,idx)+gearbox(1,idx2)*accelPoints
            
