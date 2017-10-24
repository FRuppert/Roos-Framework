%Candidate motor data
function [motorCandidates,motorName]= getMotorData
%This function adds motor data from this list to the data matrix used for
%selections
%
% Structure:
% 1: Motor ID
% 2: speed constant
% 3: torque constant
% 4: winding resistance
% 5: motor inertia
% 6: max RPM
% 7: continuous torque

%To add a new motor just copy an existing block and change the values
tempID=0;
% %% U8 Kv170
% tempID=tempID+1;
% motorID(tempID)=tempID;
% motorName(tempID)= "U8KV170";
% speedConstant(tempID)=170;  %[rpm/V]
% resistance(tempID)=0.089;   %[Ohm]
% inertia(tempID)=0;  %[kgcm^2]
% maxRPM(tempID)=5000;
% continuousTorque(tempID)=2;
% 
% %% Tmotor 4004KV300
% tempID=tempID+1;
% motorID(tempID)=tempID;
% motorName(1,tempID)= "4004KV300";
% speedConstant(tempID)=300;  %[rpm/V]
% resistance(tempID)=0.2325;   %[Ohm]
% inertia(tempID)=0.1294;  %[kgcm^2]
% maxRPM(tempID)=6100;
% continuousTorque(tempID)=2;
% 
% %% Tmotor 4006KV380
% tempID=tempID+1;
% motorID(tempID)=tempID;
% motorName(tempID)= "4006KV380";
% speedConstant(tempID)=380;  %[rpm/V]
% resistance(tempID)=0.194;   %[Ohm]
% inertia(tempID)=0;  %[kgcm^2]
% maxRPM(tempID)=5000;
% continuousTorque(tempID)=2;

%% original Roos Motors
%% PSA60/4-50
tempID=tempID+1;
motorID(tempID)=tempID;
motorName(tempID)= "PSA60/4-50";
speedConstant(tempID)=60/(2*pi*0.52);  %[rpm/V]
resistance(tempID)=14.9;   %[Ohm]
inertia(tempID)=0.79;  %[kgcm^2]
maxRPM(tempID)=8000;
continuousTorque(tempID)=0.76;
%% PSA60/4-75
tempID=tempID+1;
motorID(tempID)=tempID;
motorName(tempID)= "PSA60/4-75";
speedConstant(tempID)=60/(2*pi*0.62);  %[rpm/V]
resistance(tempID)=9;   %[Ohm]
inertia(tempID)=0.98;  %[kgcm^2]
maxRPM(tempID)=8000;
continuousTorque(tempID)=1.2;
%% PSA60/4-112
tempID=tempID+1;
motorID(tempID)=tempID;
motorName(tempID)= "PSA60/4-112";
speedConstant(tempID)=60/(2*pi*0.63);  %[rpm/V]
resistance(tempID)=5.9;   %[Ohm]
inertia(tempID)=1.28;  %[kgcm^2]
maxRPM(tempID)=8000;
continuousTorque(tempID)=1.8;
%% Create data matrix
motorCandidates=[motorID; speedConstant; 60./(2*pi.*speedConstant); resistance; inertia.*1e-4; maxRPM; continuousTorque];

