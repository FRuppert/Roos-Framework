function  [  torqueRMS  ,torqueLoadRMS ,torquePeak ,torqueLoadMax, powerLoadMax, powerMax, energy,workLoad, motorName,gearbox   ]=selectMotor(accelPoints,torquePoints,timeStep)
% the function sizes the motor/gear combinations

%Constant
% gearRatioResolution=0.1;


%load motor data
[motors, motorName]=getMotorData;

%load gear data
[gearData,teeth]=getGearData;
gearbox=calculateGearboxInertia;

[velocity,position]=integrateAcceleration(accelPoints,timeStep);
%calculate matrix
loadRpmMax=max(velocity)*60/(2*pi);

%calculate Load constants
[k1,k2,k3]=calculateLoadConstants(accelPoints,torquePoints,timeStep);


% %calculate torque values
 torqueLoadMax = max(abs(torquePoints));
 torqueLoadRMS = sqrt(k2);

%calculate power
powerLoad= torquePoints.*velocity;
% powerLoadTemp=powerLoad;
% for idx=1:length(powerLoad)
%     if powerLoadTemp(idx)<0
%         powerLoadTemp(idx)=0;
%     end
% end
% energyLoad=

%make sure energy is positive

workTemp =powerLoad;
for idx=1:length(workTemp)
    if(workTemp(idx) < 0)
        workTemp(idx) = 0;
    end
end
    
workLoad = sum(workTemp*timeStep);


%calculate max gear ratio for motor-gear combinations
% for idx=1:size(motors,2)
%     maxGearRatio(idx) = round(1/gearRatioResolution*min(motors(6,idx), max(gears(1,idx))/min(gears(1,idx)/MaxLRPM)))*gearRatioResolution;
%     gearRatioVector=[1:gearRatioResolution:maxGearRatio(idx)];
% end

%calculate load torque part CP
for idx=1:size(gearData,2)
    inputPower=torquePoints.*velocity/gearData(2,idx);
end

%calculate required RMS torque
for idx=1:size(motors,2)
    for idx2=1:size(gearbox,2)
        torqueRMS(idx,idx2)=sqrt((motors(5,idx)+gearbox(2,idx2))^2*gearbox(1,idx2)^2*k1...
                            +1/(gearbox(1,idx2)^2*gearData(2,1)^2)*k2...
                            +2*((motors(5,idx)+gearbox(2,idx2))/gearData(2,1)*k3));
                            
        if torqueRMS(idx,idx2)>motors(7,idx) % continuous torque rating
            torqueRMS(idx,idx2)= NaN;
            torquePeak(idx,idx2)=NaN;
            powerLoadMax(idx,idx2)=NaN;
            work(idx,idx2)=NaN;
        else
            torqueInstant=(motors(5,idx)+gearbox(2,idx2))*accelPoints*gearbox(1,idx2)+torquePoints/(gearbox(1,idx2)*gearData(2));
            torquePeak(idx,idx2)= max(abs(torqueInstant));
            powerMech= inputPower+(motors(5,idx)+gearbox(2,idx2))*accelPoints.*velocity*gearbox(1,idx2)^2;
            powerLoss= motors(4,idx)*torqueInstant.^2/motors(3,idx);
            [powerMax(idx,idx2),powerMaxindex(idx,idx2)]=max(powerLoss+powerMech);
            if(powerMech<0)
                energy(idx,idx2)=0;
            else
                energy(idx,idx2)=sum(powerMech+powerLoss)*timeStep;
            end
        end
    end
end
                
            
             
