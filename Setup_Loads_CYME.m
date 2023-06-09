function [ loadQuantities ] = Setup_Loads_CYME(loads,N,busNames,Sbase,noLoadQuantities,ABI,PNLI)
%SETUP_LOADS Summary of this function goes here
%   Detailed explanation goes here

% v2struct(network);
v2struct(noLoadQuantities);
% availableBusIndices=network.availableBusIndices;
availableBusIndices = ABI;
phaseNodesLinIndices = PNLI;

%% 4. Setting up loads:
% [loadBuses,loadTypes,Ph1,Ph2,Ph3,Ph4,Ph5,Ph6] = importloads([datapath,'/Spot Loads']);
% loadBuses = loads{:,1};
loadTypes = loads{:,2};
Ph1 = cell2mat(loads{:,3});
Ph2 = cell2mat(loads{:,4});
Ph3 = cell2mat(loads{:,5});
Ph4 = cell2mat(loads{:,6});
Ph5 = cell2mat(loads{:,7});
Ph6 = cell2mat(loads{:,8});

loadBusesStr = loads{:,1};
for i = 1:length(loadBusesStr)
    loadBuses(i) = str2double(loadBusesStr{i});
end
loadTypes = loads{:,2};

% loadBuses=cellstr(num2str(loadBuses));
loadTypes=string(loadTypes);

sL=zeros(N*3,2);
yL=zeros(N*3,2);
iL=zeros(N*3,2);

cMat=zeros(3*N,2);
ePage=zeros(3*N,3*N,2);
gMat=zeros(3*N,3);  % defines the load type  gVec(1) PQ, gVec(2) I , gVec(3) Y

vNomMags=[1;1;1];
vNomPhases=degrees2radians([0;-120;120]);
vNom=vNomMags.*exp(sqrt(-1)*vNomPhases);

for ii=1:length(loadBuses)
    
    nIdx=find(strcmp(busNames,loadBuses(ii)));

    linIdx1=phaseNodesLinIndices(nIdx,1);
    linIdx2=phaseNodesLinIndices(nIdx,2);
    linIdx3=phaseNodesLinIndices(nIdx,3);

    pLoad=[Ph1(ii), Ph3(ii), Ph5(ii)]*1000/Sbase;
    qLoad=[Ph2(ii), Ph4(ii), Ph6(ii)]*1000/Sbase;
    sLoad=(pLoad+1j*qLoad).';

    switch loadTypes{ii}

        case 'Y-PQ'
            sL([linIdx1,linIdx2,linIdx3],1)=sLoad;

            gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;

            cMat(linIdx1,1)=1;
            ePage(linIdx1, linIdx1,1)=1;

            cMat(linIdx2,1)=1;
            ePage(linIdx2,linIdx2,1)=1;
            
            cMat(linIdx3,1)=1;
            ePage(linIdx3,linIdx3,1)=1;

        case 'Y-PR'
            sL([linIdx1,linIdx2,linIdx3],1)=sLoad;

            gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;

            cMat(linIdx1,1)=1;
            ePage(linIdx1,linIdx1,1)=1;

            cMat(linIdx2,1)=1;
            ePage(linIdx2,linIdx2,1)=1;
            
            cMat(linIdx3,1)=1;
            ePage(linIdx3,linIdx3,1)=1;
            
        case  'Y-I'
            
            iL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./vNom);

            gMat(linIdx1,2)=1;
            gMat(linIdx2,2)=1;
            gMat(linIdx3,2)=1;
            
            cMat(linIdx1,1)=1;
            ePage(linIdx1,linIdx1,1)=1;

            cMat(linIdx2,1)=1;
            ePage(linIdx2,linIdx2,1)=1;
            
            cMat(linIdx3,1)=1;
            ePage(linIdx3,linIdx3,1)=1;
            %
        case 'Y-Z'

            yL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad);

            gMat(linIdx1,3)=1;
            gMat(linIdx2,3)=1;
            gMat(linIdx3,3)=1;

            cMat(linIdx1,1)=1;
            ePage(linIdx1,linIdx1,1)=1;

            cMat(linIdx2,1)=1;
            ePage(linIdx2,linIdx2,1)=1;
            
            cMat(linIdx3,1)=1;
            ePage(linIdx3,linIdx3,1)=1;
            
        case 'D-PQ'
            
            sL([linIdx1,linIdx2,linIdx3],1)=sLoad;
            sL(linIdx1,2)=sLoad(3);
            sL(linIdx2,2)=sLoad(1);
            sL(linIdx3,2)=sLoad(2);
            
            gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;

            cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
            ePage(linIdx1,linIdx1,1)=1;
            ePage(linIdx1,linIdx2,1)=-1;
            ePage(linIdx1,linIdx3,2)=1;
            ePage(linIdx1,linIdx1,2)=-1;

            cMat(linIdx2,1)=1;
            cMat(linIdx2,2)=-1;
            ePage(linIdx2,linIdx2,1)=1;
            ePage(linIdx2,linIdx3,1)=-1;
            ePage(linIdx2,linIdx1,2)=1;
            ePage(linIdx2,linIdx2,2)=-1;

            cMat(linIdx3,1)=1;
            cMat(linIdx3,2)=-1;
            ePage(linIdx3,linIdx3,1)=1;
            ePage(linIdx3,linIdx1,1)=-1;
            ePage(linIdx3,linIdx2,2)=1;
            ePage(linIdx3,linIdx3,2)=-1;

        case 'D-I'

            v0AB=vNom(1)-vNom(2);
            v0BC=vNom(2)-vNom(3);
            v0CA=vNom(3)-vNom(1);
            v0D=[v0AB; v0BC; v0CA];
            iL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./v0D);
            
            iL(linIdx1,2)=conj(sLoad(3)./v0D(3));
            iL(linIdx2,2)=conj(sLoad(1)./v0D(1));
            iL(linIdx3,2)=conj(sLoad(2)./v0D(2));
            
            gMat(linIdx1,2)=1;
            gMat(linIdx2,2)=1;
            gMat(linIdx3,2)=1;
            
            cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
            ePage(linIdx1,linIdx1,1)=1;
            ePage(linIdx1,linIdx2,1)=-1;
            ePage(linIdx1,linIdx3,2)=1;
            ePage(linIdx1,linIdx1,2)=-1;
            
            cMat(linIdx2,1)=1;
            cMat(linIdx2,2)=-1;
            ePage(linIdx2,linIdx2,1)=1;
            ePage(linIdx2,linIdx3,1)=-1;
            ePage(linIdx2,linIdx1,2)=1;
            ePage(linIdx2,linIdx2,2)=-1;

            cMat(linIdx3,1)=1;
            cMat(linIdx3,2)=-1;
            ePage(linIdx3,linIdx3,1)=1;
            ePage(linIdx3,linIdx1,1)=-1;
            ePage(linIdx3,linIdx2,2)=1;
            ePage(linIdx3,linIdx3,2)=-1;
            
            
        case 'D-Z'
            
            yL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./3);
            yL(linIdx1,2)=conj(sLoad(3)./3);
            yL(linIdx2,2)=conj(sLoad(1)./3);
            yL(linIdx3,2)=conj(sLoad(2)./3);
            
            gMat(linIdx1,3)=1;
            gMat(linIdx2,3)=1;
            gMat(linIdx3,3)=1;
            
            cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
            ePage(linIdx1,linIdx1,1)=1;
            ePage(linIdx1,linIdx2,1)=-1;
            ePage(linIdx1,linIdx3,2)=1;
            ePage(linIdx1,linIdx1,2)=-1;
            
            
            cMat(linIdx2,1)=1;
            cMat(linIdx2,2)=-1;
            ePage(linIdx2,linIdx2,1)=1;
            ePage(linIdx2,linIdx3,1)=-1;
            ePage(linIdx2,linIdx1,2)=1;
            ePage(linIdx2,linIdx2,2)=-1;
            
            
            
            cMat(linIdx3,1)=1;
            cMat(linIdx3,2)=-1;
            ePage(linIdx3,linIdx3,1)=1;
            ePage(linIdx3,linIdx1,1)=-1;
            ePage(linIdx3,linIdx2,2)=1;
            ePage(linIdx3,linIdx3,2)=-1;
            %
        otherwise
            sLoad=zeros(size(sLoad));
    end
    
end

sL_load=sL(availableBusIndices(1:end-3),:);
iL_load=iL(availableBusIndices(1:end-3),:);
yL_load=yL(availableBusIndices(1:end-3),:);
ePage=ePage(availableBusIndices(1:end-3), availableBusIndices(1:end-3), :);
gMat=gMat(availableBusIndices(1:end-3), :);
cMat=cMat(availableBusIndices(1:end-3),:);
%%
YL=getYLoadImpedance(cMat, ePage, yL_load);


loadQuantities=v2struct(sL_load, iL_load, yL_load, ePage, gMat, cMat, YL);
end

