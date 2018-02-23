function  [  ]=calculateInertiaLoad(accelPoints,torquePoints,timeStep)
% the function calculates the torque constants and the power for a given
% load case scenario

%calculate matrix
loadRpmMax=max(velocity)*60/(2*pi);
%calculate torque values


%calculate power
powerLoad= torqueLoad.*velocity;
powerMean= norm(powerLoad,1)*length(powerLoad);
powerMax= max(powerLoad);

%make sure energy 

workTemp =powerLoad;
for idx=1:length(workTemp)
    if(workTemp(idx) < 0)
        workTemp(idx) = 0;
    end
end
    
workLoad = sum(workTemp*timeStep);

