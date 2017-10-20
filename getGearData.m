function [gearData,teeth]=getGearData

%% Gearcandidate 1
maxGearRPM = 6000; %Max ang. vel (motor side) RPM
gearEff = 0.97;    %Efficiency
density=
modul=1;
teeth=[10,20,30,40,50,60];

gearData=[maxGearRPM;gearEff; density,modul];



