function [gearData,teeth]=getGearData
%This function provides the characteristics for a specific set of spur
%gears. 
% Output: 
% 1: max gear RPM
% 2: gear efficiency
% 3: material density
% 4: gear module
%
% teeth: array of possible teeth counts
%% Gear candidate 1
maxGearRPM = 6000;  %Max ang. vel (motor side) RPM
gearEff = 0.97;     %Efficiency
density= 1.4;        %[g/cm^3]
modul=1;            %gear modul
teeth=[10,20,30,40,50,60];  % available spur gears

gearData=[maxGearRPM;gearEff; density*1e-9;modul];



