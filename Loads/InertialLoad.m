%Example load file, this file implements an inertial load.
%Modify the file to implement the load in the design case.
%Run this file before the motor selection file is executed.
%Fredrik Roos, December 2004.
close all;
format short;
clear all;


% Acceleration, speed and position vectors.
Acc=150;
acc(1:20) = 0;
acc(21:30) = Acc;
acc(31:40) = -Acc;
acc(41:60) = 0;
acc(61:70) = -Acc;
acc(71:80) = Acc;
acc(81:120) = 0;
acc(121:130) = -Acc;
acc(131:140) = Acc;
acc(141:160) = 0;
acc(161:170) = Acc;
acc(171:180) = -Acc;
acc(181:201) = 0;

timeStep= 0.01; %resultion on load cycle
t=(0:timeStep:2); %time vector
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
end

% Load Torque vector
JL = 0.4;
Tl = JL.*acc; %Load torque


MaxLRPM = max(v)*60/(2*pi); %Maximum RPM during the loadcycle

figure
%subplot(2,1,1); plot(t,acc,'b');
hold on;

subplot(2,1,1); plot(t,v,'k:','linewidth',1.5);
hold on
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

%print -depsc -tiff -f load.eps

%Power...T*w
figure
Pl = Tl.*v;
plot(t,Pl,'linewidth',1.5);
%grid;
Plmean=norm(Pl,1)*timeStep/tau;
Plmax=max(Pl);
hold on
line(t,ones(size(t))*Plmean,'Color','g','LineStyle','--')
line(t,ones(size(t))*Plmax,'Color','r','LineStyle','--')
title('Power as function of time');
xlabel('Time [s]')
ylabel('Power [W]')
legend('Power',['P_{mean} ',num2str(Plmean(1)),' W'],['P_{peak} ',num2str(Plmax(1)),' W']);

%Energy
%Only positive energy are comming in to the system...

Wtemp =Pl;
for i=1:length(Wtemp)
    if(Wtemp(i) < 0)
        Wtemp(i) = 0;
    end
end
    
Wload = sum(Wtemp*timeStep);
