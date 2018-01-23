%Implementation of motor/gear sizing method
% Fredrik Roos, Department of Machine Design, KTH, Stockholm
% fredrikr@md.kth.se , www.md.kth.se
% 2004

clear Trms Pmax Pmaxp Text_M No Trmso Pmeano Pmaxo Tpeak W;

CandidateMotorData;     %Read data on candidate motors
CandidateGearData;      %Read data on cadidate gears

GRres = 0.1; %Gear ratio resolution. 

%Calculate max gear ratio with the maximum allowed speed of the motor and gearhead.
maxN = round(1/GRres*min(RPMmax, maxGearRPM)/MaxLRPM)*GRres;
n = [1:GRres:maxN];   %gear ratio vector

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

for (i=1:length(Tm)) %Do this for all motors
        Trms(i,:) = sqrt((Jm(i)+Jg)^2*n.^2*k1+1./(n.^2*gearEff^2)*k2+2*(Jm(i)+Jg)/gearEff*k3); %Motor required RMS torque
        for(j=1 : length(n)) %For all gear ratios
            if (Trms(i,j) > Tm(i)) % The motor /gear ratio combination can NOT drive the load continous.
                 Trms(i,j) = NaN;   %Eliminate corresponding data points.
                Tpeak(i,j) = NaN;
                Pmax(i,j) = NaN;
                Pmaxp(i,j) = NaN;
                W(i,j) = NaN;
            else    % The motor gearhead combination CAN drive the load
                Tinst = (Jm(i)+Jg)*acc*n(j)+Tl/(n(j)*gearEff); %Torque a.f.o. time 
                Tpeak(i,j)= max(abs(Tinst)); %Load cycle required motor peak torque.
                Pmech=CP+(Jm(i)+Jg)*acc.*v*n(j)^2;  %Mechanical Power
                Ploss = R(i) * Tinst.^2/Kt(i)^2; %Resistive losses
                [Pmax(i,j), Pmaxp(i,j)] = max(Ploss+Pmech);   %Maximum abs motor power     
                Wtemp1 = Pmech; 
                Wtemp2 = Ploss;
              
               for k=1:length(Wtemp1) %Set the energy to zero when the mechanical power is negative (braking).
                    if(Wtemp1(k) < 0)
                        Wtemp1(k) = 0;
                        Wtemp2(k) = 0;
                    end
                end
                W(i,j) = sum((Wtemp1+Wtemp2))*timeStep; %Required energy                                       
                end
        end    
                  
        %Legend text
		Text_M(i,:)=['M ', num2str(i), '  '];     
end

figure(1) %Plot Req. motor RMS torque  
plot(n,Trms,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(2) %Plot Req. motor peak power
plot(n,Pmax,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(3) %Plot Req. energy
plot(n,W,'linewidth',1);
Wline=ones(size(n))*Wload;
line(n,Wline,'LineStyle',':');
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)

figure(4) %Plot peak torque req.
plot(n,Tpeak,'linewidth',1);
test=axis;
plot(Ngear,test(3) ,'X','MarkerSize',14)
legend(MotorName)
