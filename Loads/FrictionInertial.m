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
t=(0:timeStep:5); %time vector
tau = timeStep*length(t); %total time

v = t;
p = t;
summation=0;
summation2 = 0;

for i=1 : length(acc)
    summation = summation + acc(i)*timeStep;
    v(i) = summation;
    summation2= summation2 +v(i)*timeStep;
    p(i) = summation2;
    v(120) = 0.1;
    v(440) = 0.1;
    v(230) = -0.1;
    v(350) = -0.1;
end

%Load Torque vector
JL = 0.012;
TL =7.5;

Tl = sign(v)*TL +acc*JL;

MaxLRPM = max(v)*60/(2*pi); %Maximum RPM during the loadcycle

figure
%subplot(2,1,1); plot(t,acc,'b');
hold on;

subplot(2,1,1); plot(t,v,'k:','linewidth',1.5);
hold on;
subplot(2,1,1); plot(t,p,'g','linewidth',1.5);
%grid;
set(gca,'Fontsize',12)
xlabel('time [s]')
title(['Load profile'])
set(gca,'Fontsize',10)
%legend('Ang. Acceleration [rad/s^2]', 'Ang. Velocity [rad/s]', 'Pos [rad]')
legend('Ang. Velocity [rad/s]', 'Pos [rad]')



%Load constants....for RMS calculations rms = sqrt(Cr^2*n^2*k1+k2/(n^2)+2*Cr*k3)
%Torque
k1 = sum(acc.^2*timeStep)/tau;
k2 = sum(Tl.^2*timeStep)/tau;
k3 = sum(Tl.*acc*timeStep)/tau;
Tlmax = max(abs(Tl));
Tlrms = sqrt(k2);



subplot(2,1,2);plot(t,Tl,'b','linewidth',1.5);
hold on;
temp=ones(size(t))*Tlrms;
subplot(2,1,2);line(t,temp,'Color','g','LineStyle','--');
temp=ones(size(t))*Tlmax;
subplot(2,1,2);line(t,temp,'Color','r','LineStyle','-.');

set(gca,'Fontsize',12)
%grid;
xlabel('time [s]')
ylabel('torque [Nm]')
set(gca,'Fontsize',10)
legend('Load Torque', ['T_{RMS} ', num2str(Tlrms(1)),' Nm'], ['T_{Peak} ', num2str(Tlmax(1)),' Nm'])


%Power...T*w
figure
Pl = Tl.*v;
plot(t,Pl,'linewidth',1.5);
%grid;
Plmean=norm(Pl,1)*timeStep/tau;
Plmax=max(Pl);
hold on
line(t,ones(size(t))*Plmean,'Color','g','LineStyle','--')
line(t,ones(size(t))*Plmax,'Color','r','LineStyle','-.')
title('Power as function of time');
xlabel('Time [s]')
ylabel('Power [W]')
legend('Power','Mean Power','Max Power');

%Energy
%Only positive energy are comming in to the system...

Wtemp =Pl;
for i=1:length(Wtemp)
    if(Wtemp(i) < 0)
        Wtemp(i) = 0;
    end
end
    
Wload = sum(Wtemp*timeStep);
