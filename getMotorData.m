%Candidate motor data
function motorCandidate= getMotorData;

RPMmax = 8000; %Maximum motor speed.
%% U8 Kv170
motorName= 'U8KV170';
speedConstant=170;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
resistance=0.089;   %[Ohm]
inertia=0;  %[kgcm^2]
maxRPM=10000;
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4;rpmMAX];
motorCandidate=[motorCandidate; motor];

%% Tmotor 4004KV
motorName= '4004KV400';
speedConstant=400;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
Resistance=0.452;   %[Ohm]
inertia=0;  %[kgcm^2]
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4;rpmMAX];
motorCandidate=[motorCandidate; motor];

%% Tmotor 4006KV
motorName= '400KV380';
speedConstant=380;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
Resistance=0.194;   %[Ohm]
inertia=0;  %[kgcm^2]
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4;rpmMAX];
motorCandidate=[motorCandidate; motor];





