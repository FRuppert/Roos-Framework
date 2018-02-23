function plotLoadcase(accelPoints, torquePoints,timeStep)

time=(0:length(accelPoints)-1)*timeStep;
[velocity, position]=integrateAcceleration(accelPoints,timeStep);

% plot dynamics
figure
subplot(3,1,1); plot(time,accelPoints,'b');
hold on;
subplot(3,1,1); plot(time,velocity,'k:','linewidth',1.5);
hold on
subplot(3,1,1); plot(time,position,'g','linewidth',1.5);
%grid;
set(gca,'Fontsize',12)
xlabel('time [s]')
title(['Load profile'])
set(gca,'Fontsize',10)
legend('Ang. Acceleration [rad/s^2]', 'Ang. Velocity [rad/s]', 'Pos [rad]')

% plot torque curve

torqueLoadMax = max(abs(torquePoints));
torqueLoadRMS = sqrt(sum(torquePoints.^2*timeStep)/(timeStep*length(torquePoints)));


subplot(3,1,2);plot(time,torquePoints,'linewidth',1.5);
hold on;
temp=ones(size(torquePoints))*torqueLoadRMS;
subplot(3,1,2);line(time,temp,'Color','g','LineStyle','--');
temp=ones(size(torquePoints))*torqueLoadMax;
subplot(3,1,2);line(time,temp,'Color','r','LineStyle','-.');

set(gca,'Fontsize',12)
%grid;
xlabel('time [s]')
ylabel('torque [Nm]')
set(gca,'Fontsize',10)
legend('Load Torque', ['T_{RMS} ', num2str(torqueLoadRMS(1)),' Nm'], ['T_{Peak} ', num2str(torqueLoadMax(1)),' Nm'])

% plot power
powerLoad= torquePoints.*velocity;
powerMean= norm(powerLoad,1)/length(powerLoad);
powerMax= max(powerLoad);

subplot(3,1,3);
plot(time,powerLoad,'linewidth',1.5);
hold on;
%grid;
hold on
line(time,ones(size(time))*powerMean,'Color','g','LineStyle','--')
line(time,ones(size(time))*powerMax,'Color','r','LineStyle','-.')
title('Power as function of time');
xlabel('Time [s]')
ylabel('Power [W]')
legend('Power','Mean Power','Max Power');