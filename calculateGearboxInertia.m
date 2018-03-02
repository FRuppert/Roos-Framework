function [gearbox]= calculateGearboxInertia(motorRpmMax,gearboxRpmMax,loadRpmMax)
% THis function calculates thepossible gear ratio and sorts them by size
% and calculates the complete reflected inertia of both spurgears for the
% ratio 
% output:
% gearbox(1) = gear ratios
% gearbox(2) = respective gearbox inertia
% [gearData,teeth]=getGearData;
% radius=teeth.*gearData(4,:)*1e-3;
% for idx1=1:length(teeth)
%    for idx2=1:length(teeth)
%        possibleRatios(idx1,idx2)=teeth(idx2)/teeth(idx1);
%        
%        gearboxInertia(idx1,idx2)=  0.5*pi*radius(idx1)^2*gearData(3)*gearData(5)*radius(idx1)^2 ...
%                                 +0.5*pi*radius(idx2)^2*gearData(3)*gearData(5)*radius(idx2)^2; 
%        
%    end
% end
% %reshape matrix into vectors
% gearbox(1,:)=reshape(possibleRatios,[1,length(radius)^2]);
% gearbox(2,:)=reshape(gearboxInertia,[1,length(radius)^2]);
% %sort gear ratios
% [gearbox(1,:),index]=sort(gearbox(1,:));
% % sort the inertias by the index of the ratio sorting
% for idx=1:length(index)
%  gearboxTemp(idx)=gearbox(2,index(idx));
% end
% gearbox(2,:)=gearboxTemp;


%% Default Roos value:
inertiaGearbox=0.0;
gearRatioResolution=0.5;
gearRatioMin=0.1;
% gearRatioMax= round(1/gearRatioResolution*min(motorRpmMax,
% gearboxRpmMax)/loadRpmMax)*gearRatioResolution; % only works for smooth
% velocities. Otherwise the inegrated accelerations accumulate and the max
% loadRPM exceed the motor and gear RPM and make the gear space smaller
gearRatioMax= 30;

gearbox(1,:)=[gearRatioMin:gearRatioResolution:gearRatioMax];
gearbox(2,:)=ones(1,size(gearbox,2))*inertiaGearbox;





