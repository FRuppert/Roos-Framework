function gearData=getGearData;

%% Gearcandidate 1
maxGearRPM = 6000; %Max ang. vel (motor side) RPM
gearEff = 0.97;    %Efficiency
inertiaGear=0;               %Gear inertia


gearData=[maxGearRPM;gearEff; inertiaGear];



