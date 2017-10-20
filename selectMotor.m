%Implementation of motor/gear sizing method
% Fredrik Roos, Department of Machine Design, KTH, Stockholm
% fredrikr@md.kth.se , www.md.kth.se
% 2004

close all;
clear Trms Pmax Pmaxp Text_M No Trmso Pmeano Pmaxo Tpeak W;

CandidateMotorData;     %Read data on candidate motors
CandidateGearData;      %Read data on cadidate gears

ResolutionGearRatio = 0.1; %Gear ratio resolution. 

%Calculate max gear ratio with the maximum allowed speed of the motor and gearhead.
maxGearRatio = round(1/ResolutionGearRatio*min(RPMmax, maxGearRPM)/MaxLRPM)*ResolutionGearRatio;
gearRatioVector = [1:ResolutionGearRatio:maxGearRatio];   %gear ratio vector

%Prepare some figures.
figure(1)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Torque [Nm]')
title(['Motor RMS torque as function of gear ratio, T_{l,rms} = ',num2str(Tlrms), 'Nm'])

figure(2)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Peak Power [W]')
title(['Motor peak power (P_{mech} + P_{loss}) as function of gear ratio, P_{l,max} = ',num2str(Plmax), 'W'])

figure(3)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Energy [J]')
title(['Consumed energy W_{l} = ',num2str(Wload), 'J'])

figure(4)
hold on;
set(gca,'Fontsize',12)
set(gca,'ColorOrder',[0 0 1],...
      'LineStyleOrder','-|:|--|-.')
xlabel('Gear ratio')
ylabel('Peak Torque [Nm]')
title(['Motor peak torque as function of gear ratio, T_{l,peak} = ',num2str(Tlmax), 'Nm'])

%Calculate the load torque part (CP) of the motor load once and for all
CP = Tl.*v/gearEff;

for (idxMotor=1:length(Tm)) %Do this for all motors
        Trms(idxMotor,:) = sqrt((Jm(idxMotor)+Jg)^2*gearRatioVector.^2*k1+1./(gearRatioVector.^2*gearEff^2)*k2+2*(Jm(idxMotor)+Jg)/gearEff*k3); %Motor required RMS torque
        for(idxGearRatio=1 : length(gearRatioVector)) %For all gear ratios
            if (Trms(idxMotor,idxGearRatio) > Tm(idxMotor)) % The motor /gear ratio combination can NOT drive the load continous.
                Trms(idxMotor,idxGearRatio) = NaN;   %Eliminate corresponding data points.
                Tpeak(idxMotor,idxGearRatio) = NaN;
                Pmax(idxMotor,idxGearRatio) = NaN;
                Pmaxp(idxMotor,idxGearRatio) = NaN;
                W(idxMotor,idxGearRatio) = NaN;
            else    % The motor gearhead combination CAN drive the load
                Tinst = (Jm(idxMotor)+Jg)*acc*gearRatioVector(idxGearRatio)+Tl/(gearRatioVector(idxGearRatio)*gearEff); %Torque a.f.o. time 
                Tpeak(idxMotor,idxGearRatio)= max(abs(Tinst)); %Load cycle required motor peak torque.
                Pmech=CP+(Jm(idxMotor)+Jg)*acc.*v*gearRatioVector(idxGearRatio)^2;  %Mechanical Power
                Ploss = R(idxMotor) * Tinst.^2/Kt(idxMotor)^2; %Resistive losses
                [Pmax(idxMotor,idxGearRatio), Pmaxp(idxMotor,idxGearRatio)] = max(Ploss+Pmech);   %Maximum abs motor power     
                Wtemp1 = Pmech; 
                Wtemp2 = Ploss;
              
               for k=1:length(Wtemp1) %Set the energy to zero when the mechanical power is negative (braking).
                    if(Wtemp1(k) < 0)
                        Wtemp1(k) = 0;
                        Wtemp2(k) = 0;
                    end
                end
                W(idxMotor,idxGearRatio) = sum((Wtemp1+Wtemp2))*timeStep; %Required energy                                       
                end
        end    
                  
        %Legend text
		Text_M(idxMotor,:)=['M ', num2str(idxMotor), '  '];     
end

figure(1) %Plot Req. motor RMS torque  
plot(gearRatioVector,Trms,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(2) %Plot Req. motor peak power
plot(gearRatioVector,Pmax,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(3) %Plot Req. energy
plot(gearRatioVector,W,'linewidth',1);
Wline=ones(size(gearRatioVector))*Wload;
line(gearRatioVector,Wline,'LineStyle',':');
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(4) %Plot peak torque req.
plot(gearRatioVector,Tpeak,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)
