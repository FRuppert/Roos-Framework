%Candidate motor data
function motorCandidates= getMotorData;
%This function adds motor data from this list to the data matrix used for
%selections
%
%To add a new motor just copy an existing block and change the values

%% U8 Kv170
tempID=1;
motorName(tempID)= 'U8KV170';
speedConstant(tempID)=170;  %[rpm/V]
resistance(tempID)=0.089;   %[Ohm]
inertia(tempID)=0;  %[kgcm^2]
maxRPM(tempID)=5000;

%% Tmotor 4004KV300
tempID=tempID+1;
motorName(tempID)= '4004KV300';
speedConstant(tempID)=300;  %[rpm/V]
resistance(tempID)=0.2325;   %[Ohm]
inertia(tempID)=0.1294;  %[kgcm^2]
maxRPM(tempID)=6100;

%% Tmotor 4006KV380
tempID=tempID+1;
motorName(tempID)= '4006KV380';
speedConstant(tempID)=380;  %[rpm/V]
resistance(tempID)=0.194;   %[Ohm]
inertia(tempID)=0;  %[kgcm^2]
maxRPM(tempID)=5000;

%% Create data matrix
motorCandidates=[motorName; speedConstant; 60/(2*pi*SpeedConstant); resistance;inertia.*1e-4;maxRPM];

