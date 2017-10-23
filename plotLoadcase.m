function plotLoadcase(accelPoints, torquePoints,timeStep)

time=(0:length(accelPoints)-1)*timeStep;
[velocity, position]=integrateAcceleration(accelPoints,timeStep);

% plot dynamics
figure
subplot(2,1,1); plot(time,accelPoints,'b');
hold on;
subplot(2,1,1); plot(time,velocity,'k:','linewidth',1.5);
hold on
subplot(2,1,1); plot(time,position,'g','linewidth',1.5);
%grid;
set(gca,'Fontsize',12)
xlabel('time [s]')
title(['Load profile'])
set(gca,'Fontsize',10)
legend('Ang. Acceleration [rad/s^2]', 'Ang. Velocity [rad/s]', 'Pos [rad]')

% plot torque curve

torqueLoadMax = max(abs(torquePoints));
torqueLoadRMS = sqrt(sum(torquePoints.^2*timeStep)/(timeStep*length(torquePoints)));


subplot(2,1,2);plot(time,torquePoints,'linewidth',1.5);
hold on;
temp=ones(size(torquePoints))*torqueLoadRMS;
subplot(2,1,2);line(time,temp,'Color','g','LineStyle','--');
temp=ones(size(torquePoints))*torqueLoadMax;
subplot(2,1,2);line(time,temp,'Color','r','LineStyle','-.');

set(gca,'Fontsize',12)
%grid;
xlabel('time [s]')
ylabel('torque [Nm]')
set(gca,'Fontsize',10)
legend('Load Torque', ['T_{RMS} ', num2str(torqueLoadRMS(1)),' Nm'], ['T_{Peak} ', num2str(torqueLoadMax(1)),' Nm'])

