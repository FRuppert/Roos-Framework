function [gearData,teeth]=getGearData
%This function provides the characteristics for a specific set of spur
%gears. 
% Output: 
% 1: max gear RPM
% 2: gear efficiency
% 3: material density
% 4: gear module
% 5: thickness
% teeth: array of possible teeth counts
%% Gear candidate 1
maxGearRPM = 5000;  %Max ang. vel (motor side) RPM
gearEff = 0.701;     %Efficiency
density= 1.4;       %[g/cm^3]
modul=1;            %gear modul
thickness=5;        %[mm]
teeth=[1,2,3,4,5];  % available spur gears

gearData=[maxGearRPM;gearEff; density*1e-9;modul;thickness];



