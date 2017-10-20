%Candidate motor data
%Fredrik Roos December 2004.
% MotorName = ['PSA 60/4-50 ';'PSA 60/4-75 ';'PSA 60/4-112';'PSA 90/6-52 '] %For plot legend, all entries need to be of the same length! 
% Tm = [0.76  1.20 1.80 2.50]  %Motor cont. torque rating Nm
% Tpeak = Tm*5;                %Motor Peak torque rating  Nm 
% Jm = [0.79  0.98 1.28 2.86]  %Motor Inertia kgcm^2
% Jm=Jm*1e-4; %kgm^2
% R = [14.9 9 5.9 3.9]         %Motor resistance Ohm
% Kt = [0.52 0.62 0.63 0.68 ]  %Motor Torque constants. 


RPMmax = 8000; %Maximum motor speed.
%% U8 Kv170
motorName= 'U8KV170';
speedConstant=170;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
resistance=0.089;   %[Ohm]
inertia=0;  %[kgcm^2]
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4];
motorCandidate=[motorCandidate; motor];

%% Tmotor 4004KV
motorName= '4004KV400';
speedConstant=400;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
Resistance=0.452;   %[Ohm]
inertia=0;  %[kgcm^2]
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4];
motorCandidate=[motorCandidate; motor];

%% Tmotor 4006KV
motorName= '400KV380';
speedConstant=380;  %[rpm/V]
torqueConstant=60/(2*pi*SpeedConstant); %[Nm/A]
Resistance=0.194;   %[Ohm]
inertia=0;  %[kgcm^2]
motor=[motorName; speedConstant; torqueConstant; resistance;inertia*1e-4];
motorCandidate=[motorCandidate; motor];





