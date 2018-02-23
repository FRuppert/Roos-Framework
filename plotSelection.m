function plotSelection(torqueRMS,torqueLoadRMS,torquePeak, torqueLoadMax, powerLoadMax ,powerMax, energy,workLoad,gearbox,motorName)
gearRatios=gearbox(1,:);

figure
subplot(2,2,1)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Torque [Nm]')
 title(['Motor RMS torque as function of gear ratio, T_{l,rms} = ',num2str(torqueLoadRMS), 'Nm'])

subplot(2,2,2)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Peak Power [W]')
 title(['Motor peak power (P_{mech} + P_{loss}) as function of gear ratio, P_{l,max} = ',num2str(powerLoadMax), 'W'])

subplot(2,2,3)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Energy [J]')
 title(['Consumed energy W_{l} = ',num2str(workLoad), 'J'])

subplot(2,2,4)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Peak Torque [Nm]')
 title(['Motor peak torque as function of gear ratio, T_{l,peak} = ',num2str(torqueLoadMax), 'Nm'])

subplot(2,2,1) 
hold on;
plot(gearRatios,torqueRMS,'linewidth',1);
test=axis;
plot(gearRatios,test(3) ,'X','MarkerSize',14)
legend(motorName)

subplot(2,2,2) %Plot Req. motor peak power
hold on;
plot(gearRatios,powerMax,'linewidth',1);
test=axis;
plot(gearRatios,test(3) ,'X','MarkerSize',14)
legend(motorName)

subplot(2,2,3) %Plot Req. energy
hold on;
plot(gearRatios,energy,'linewidth',1);
Wline=ones(size(gearRatios))*workLoad;
line(gearRatios,Wline,'LineStyle',':');
test=axis;
plot(gearRatios,test(3) ,'X','MarkerSize',14)
legend(motorName)

subplot(2,2,4)%Plot peak torque req.
hold on;
plot(gearRatios,torquePeak,'linewidth',1);
test=axis;
plot(gearRatios,test(3) ,'X','MarkerSize',14)
legend(motorName)
