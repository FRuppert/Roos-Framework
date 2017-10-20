function [gearbox]= calculateGearboxInertia(density, teeth,modul, thickness)
% THis function calculates thepossible gear ratio and sorts them by size
% and calculates the complete reflected inertia of both spurgears for the
% ratio 
[gearData,teeth]=getGearData;
radius=teeth.*modul;
for idx1=1:length(teeth)
   for idx2=1:length(teeth)
       possibleRatios(idx1,idx2)=teeth(idx2)/teeth(idx1);
       
       gearboxInertia(idx1,idx2)=  0.5*pi.*radius(idx1).^2*density*thickness.*radius(idx1).^2
                                +0.5*pi.*radius(idx2).^2*density*thickness.*radius(idx2).^2; 
       
   end
end
%reshape matrix into vectors
gearbox(1,:)=reshape(possibleRatios,[1,length(radius)^2]);
gearbox(2,:)=reshape(gearboxInertia,[1,length(radius)^2]);
%sort gear ratios
[gearbox(1,:),index]=sort(gearbox(1,:));
% sort the inertias by the index of the ratio sorting
for idx=1:length(index)
 gearboxTemp(idx)=gearbox(2,index(idx));
end
gearbox(2,:)=gearboxTemp;



%sort the ratios by size and use the same sorting for the respective
%inertias
