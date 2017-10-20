%Example load file, this file implements a combined load.
%Run this file before the motor selection file is executed.
%Fredrik Roos, December 2004.
close all;
format short;
clear all;

% Acceleration, speed and position vectors.
Acc=350;
acc(1:40) = 0;
acc(51:70) = Acc;
acc(71:100) = 0;
acc(101:120) = -Acc;
acc(121:160) = 0;
acc(161:180) = -Acc;
acc(181:210) = 0;
acc(211:230) = Acc;
acc(231:300) = 0;
acc(301:320) = -Acc;
acc(321:330) = 0;
acc(331:350) = Acc;
acc(351:390) = 0;
acc(391:410) = +Acc;
acc(411:420) = 0;
acc(421:440) = -Acc;
acc(441:501) = 0;
timeStep= 0.01; %resultion on load cycle
time=(0:timeStep:5); %time vector
totalTime = timeStep*length(time); %total time

velocity = length(time);
position = length(time);
summation=0;
summation2 = 0;

for idx=1 : length(acc)
    summation = summation + acc(idx)*timeStep;
    velocity(idx) = summation;
    summation2= summation2 +velocity(idx)*timeStep;
    position(idx) = summation2;
    velocity(120) = 0.1;
    velocity(440) = 0.1;
    velocity(230) = -0.1;
    velocity(350) = -0.1;
end

%Load Torque vector
JL = 0.012;
TL =7.5;

Tl = sign(velocity)*TL +acc*JL;

MaxLRPM = max(velocity)*60/(2*pi); %Maximum RPM during the loadcycle

figure
%subplot(2,1,1); plot(t,acc,'b');
hold on;

subplot(2,1,1); plot(time,velocity,'k:','linewidth',1.5);
hold on;
subplot(2,1,1); plot(time,position,'g','linewidth',1.5);
%grid;
set(gca,'Fontsize',12)
xlabel('time [s]')
title(['Load profile'])
set(gca,'Fontsize',10)
%legend('Ang. Acceleration [rad/s^2]', 'Ang. Velocity [rad/s]', 'Pos [rad]')
legend('Ang. Velocity [rad/s]', 'Pos [rad]')



%Load constants....for RMS calculations rms = sqrt(Cr^2*n^2*k1+k2/(n^2)+2*Cr*k3)
%Torque
k1 = sum(acc.^2*timeStep)/totalTime;
k2 = sum(Tl.^2*timeStep)/totalTime;
k3 = sum(Tl.*acc*timeStep)/totalTime;
Tlmax = max(abs(Tl));
Tlrms = sqrt(k2);



subplot(2,1,2);plot(time,Tl,'b','linewidth',1.5);
hold on;
temp=ones(size(time))*Tlrms;
subplot(2,1,2);line(time,temp,'Color','g','LineStyle','--');
temp=ones(size(time))*Tlmax;
subplot(2,1,2);line(time,temp,'Color','r','LineStyle','-.');

set(gca,'Fontsize',12)
%grid;
xlabel('time [s]')
ylabel('torque [Nm]')
set(gca,'Fontsize',10)
legend('Load Torque', ['T_{RMS} ', num2str(Tlrms(1)),' Nm'], ['T_{Peak} ', num2str(Tlmax(1)),' Nm'])


%Power...T*w
figure
Pl = Tl.*velocity;
plot(time,Pl,'linewidth',1.5);
%grid;
Plmean=norm(Pl,1)*timeStep/totalTime;
Plmax=max(Pl);
hold on
line(time,ones(size(time))*Plmean,'Color','g','LineStyle','--')
line(time,ones(size(time))*Plmax,'Color','r','LineStyle','-.')
title('Power as function of time');
xlabel('Time [s]')
ylabel('Power [W]')
legend('Power','Mean Power','Max Power');

%Energy
%Only positive energy are comming in to the system...

Wtemp =Pl;
for idx=1:length(Wtemp)
    if(Wtemp(idx) < 0)
        Wtemp(idx) = 0;
    end
end
    
Wload = sum(Wtemp*timeStep);
