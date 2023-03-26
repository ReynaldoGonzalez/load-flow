%% 5. Create Ytilde and Ybranch
epsilon=1e-5;

% Index for storing the Admittance values
admitIdx = 1:3:numBranch*3;
Admittance = zeros(numBranch*3,5*3); % 3 columns for each Y, Z value

regulatorTypes = [];

% Phase of each branch
phases = zeros(numBranch,3);

CNodes=sparse(zeros(numBranch,numBus));
CIndices=sparse(zeros(numBranch*3, numBus*3));
Ytilde=sparse(zeros(3*numBus));
Ybranch=sparse(zeros(3*numBranch));

% Traverse the network
for ii=1:length(lineBuses1)
    jBranchIdx=(ii-1)*3+1:ii*3;
    bus1=lineBuses1(ii);
    bus2=lineBuses2(ii);
    nIdx=find(strcmp(busNames,bus1));
    mIdx=find(strcmp(busNames,bus2));
    jmIdx=(mIdx-1)*3+1:mIdx*3;
    jnIdx=(nIdx-1)*3+1:nIdx*3;

    CNodes(ii,nIdx)=1;
    CNodes(ii,mIdx)=-1;

    Cmat=zeros(3);
    
    YtildeNMn=zeros(3,3);
    YtildeNMm=zeros(3,3);
    YtildeMNn=zeros(3,3);
    YtildeMNm=zeros(3,3);

    switch lineStatuses{ii}
        case 3 % reg 1
            tapAB=7;
            tapBC=4;

            arAB= 1-0.00625*tapAB;
            arBC=1-0.00625*tapBC;
            
            Av=[arAB, 1-arAB,0;
                0, 1, 0 ;
                0, 1-arBC,arBC];
            Ai=[1/arAB, 0,0;
                1-1/arAB,1,1-1/arBC;
                0, 0, 1/arBC];

            %
            
            ztReg=(2.5/2)*3*0.01i;
            Zregulator=[ztReg, 0, 0; 0 0 0; 0 0 ztReg];

            Zseries=Zcfg(:,:,lineCodes(ii)-720);
            Yshunt=Ycfg(:,:,lineCodes(ii)-720);
            availablePhases=find(any(Zseries));
            
            Zseries=Zseries(availablePhases,availablePhases);
            Yshunt=Yshunt(availablePhases,availablePhases);
            
            % length of the line:
            lineLength=lineLengths(ii);

            YtildeNMn(availablePhases,availablePhases)=( inv(Zseries*lineLength)/Ybase+0*Yshunt*lineLength/Ybase);
            YtildeNMm(availablePhases,availablePhases)=(inv(Zseries*lineLength)/Ybase);
            YtildeMNn(availablePhases,availablePhases)=(inv(Zseries*lineLength)/Ybase);
            YtildeMNm(availablePhases,availablePhases)=(inv(Zseries*lineLength)/Ybase+0*Yshunt*lineLength/Ybase);

            FSVR=eye(3)+ YtildeNMn*inv(Av)*Zregulator*Ai;
            % Ytilde
            if strcmp(regulatorTypes,'ideal')
                
                Ytilde(jnIdx, jnIdx)= Ytilde(jnIdx, jnIdx)+Ai*(YtildeNMn)*inv(Av);
                Ytilde(jnIdx, jmIdx)=-Ai*YtildeNMm;
                Ytilde(jmIdx,jmIdx)=Ytilde(jmIdx,jmIdx)+YtildeMNm;
                Ytilde(jmIdx,jnIdx)=-YtildeMNn*inv(Av);
                
            else
                
                Ytilde(jnIdx, jnIdx)= Ytilde(jnIdx, jnIdx)+Ai*inv(FSVR)*(YtildeNMn)*inv(Av);
                Ytilde(jnIdx, jmIdx)=-Ai*inv(FSVR)*YtildeNMm;
                Ytilde(jmIdx,jmIdx)=Ytilde(jmIdx,jmIdx)+YtildeMNm - YtildeMNm*inv(Av)*Zregulator*Ai*inv(FSVR)*YtildeNMm;
                Ytilde(jmIdx,jnIdx)=-(YtildeMNn*inv(Av)-YtildeMNn*inv(Av)*Zregulator*Ai*inv(FSVR)*(YtildeNMn)*inv(Av));
            end
            regulatorVoltageGains{1}=Av;
            regulatorCurrentGains{1}=Ai;
            regulatorImpedances{1}=Zregulator;
            regulatorYNMn{1}=Ai*inv(FSVR)*(YtildeNMn)*inv(Av);
            regulatorYNMm{1}=Ai*inv(FSVR)*YtildeNMm;
            
            % Ybranch
            YbranchII=zeros(3,3);
            YbranchII(availablePhases,availablePhases)=(inv(Zseries*lineLength)/Ybase);
            Ybranch(jBranchIdx,jBranchIdx)=YbranchII;

            Cmat=zeros(3);
            Cmat(availablePhases,availablePhases)=eye(length(availablePhases));
            CIndices( jBranchIdx, jnIdx) = Cmat;
            CIndices( jBranchIdx, jmIdx) = -Cmat;
            
        case 2
            
            zt  =0.01*[2+8i]*3;
            yt=1./zt;
            Y2= (1/3) *[ 2*yt, -yt, -yt; -yt,2*yt,-yt; -yt,-yt,2*yt];

            Y3=(1/sqrt(3))*[-yt, yt, 0;
                0, -yt, yt;
                yt, 0, -yt];

            Y1=diag([yt;yt;yt]);
            
            Y2hat1=Y2+abs(yt)*epsilon*eye(3);
            Y2hat2=Y2+abs(yt)*(epsilon/2)*eye(3);

            availablePhases=[1;2;3];

            YtildeNMn(availablePhases,availablePhases)=Y2hat1;
            YtildeNMm(availablePhases,availablePhases)=Y2hat2;
            YtildeMNn(availablePhases,availablePhases)=Y2hat2;
            YtildeMNm(availablePhases,availablePhases)=Y2hat1;

            Ytilde(jnIdx, jnIdx)= Ytilde(jnIdx, jnIdx)+YtildeNMn;
            Ytilde(jnIdx, jmIdx)=-YtildeNMm;
            Ytilde(jmIdx,jmIdx)=Ytilde(jmIdx,jmIdx)+YtildeMNm;
            Ytilde(jmIdx,jnIdx)=-YtildeMNn;

            % Ybranch
            YbranchII=zeros(3,3);
            YbranchII(availablePhases,availablePhases)=Y2;
            Ybranch(jBranchIdx,jBranchIdx)=YbranchII;

            Cmat=zeros(3);
            Cmat(availablePhases,availablePhases)=eye(length(availablePhases));
            CIndices( jBranchIdx, jnIdx) = Cmat;
            CIndices( jBranchIdx, jmIdx) = -Cmat;
            %
            %
            %
        case 4
            zt=0.01*[0.09+1.81i]*((480/Vbase).^2)*Sbase./(500000);
            yt=1./zt;
            Y2= (1/3) *[ 2*yt, -yt, -yt; -yt,2*yt,-yt; -yt,-yt,2*yt];
            
            %               Y2hat1=Y2+abs(yt)*epsilon*(100/3)*(1/5)*eye(3);
            %                         Y2hat2=Y2+abs(yt)*(epsilon/2)*(100/3)*eye(3);
            
            Y2hat1=Y2+abs(yt)*epsilon*eye(3);
            Y2hat2=Y2+abs(yt)*(epsilon/2);

            availablePhases=[1;2;3];

            % Ytilde
            YtildeNMn(availablePhases,availablePhases)=Y2hat1;
            YtildeNMm(availablePhases,availablePhases)=Y2hat2;
            YtildeMNn(availablePhases,availablePhases)=Y2hat2;
            YtildeMNm(availablePhases,availablePhases)=Y2hat1;

            Ytilde(jnIdx, jnIdx)= Ytilde(jnIdx, jnIdx)+YtildeNMn;
            Ytilde(jnIdx, jmIdx)=-YtildeNMm;
            Ytilde(jmIdx,jmIdx)=Ytilde(jmIdx,jmIdx)+YtildeMNm;
            Ytilde(jmIdx,jnIdx)=-YtildeMNn;

            % Ybranch
            YbranchII=zeros(3,3);
            YbranchII(availablePhases,availablePhases)=Y2;
            Ybranch(jBranchIdx,jBranchIdx)=YbranchII;

            Cmat=zeros(3);
            Cmat(availablePhases,availablePhases)=eye(length(availablePhases));
            CIndices( jBranchIdx, jnIdx) = Cmat;
            CIndices( jBranchIdx, jmIdx) = -Cmat;
            
        otherwise
            
            % assign to line config
            % need line configs to Zcfg index
            % lineConfigs will be the Zcfg index or 0 if some other line
            % element
            
            Zseries=Zcfg(:,:,lineConfigs(ii));
            Yshunt=Ycfg(:,:,lineConfigs(ii));
            availablePhases=find(any(Zseries));

            Zseries=Zseries(availablePhases,availablePhases);
            Yshunt=Yshunt(availablePhases,availablePhases);
            
            % length of the line:
            lineLength=lineLengths(ii);

            Yseries=inv(Zseries);
            % Ytilde
            
            YtildeNMn(availablePhases,availablePhases)=(Yseries/lineLength/Ybase+0*Yshunt*lineLength/Ybase);
            YtildeNMm(availablePhases,availablePhases)=(Yseries/lineLength/Ybase);
            YtildeMNn(availablePhases,availablePhases)=(Yseries/lineLength/Ybase);
            YtildeMNm(availablePhases,availablePhases)=(Yseries/lineLength/Ybase+0*Yshunt*lineLength/Ybase);
            
            Ytilde(jnIdx, jnIdx)= Ytilde(jnIdx, jnIdx)+YtildeNMn;
            Ytilde(jnIdx, jmIdx)=-YtildeNMm;
            Ytilde(jmIdx,jmIdx)=Ytilde(jmIdx,jmIdx)+YtildeMNm;
            Ytilde(jmIdx,jnIdx)=-YtildeMNn;
            
            % Ybranch
            YbranchII=zeros(3,3);
            YbranchII(availablePhases,availablePhases)=(Yseries/lineLength/Ybase);
            Ybranch(jBranchIdx,jBranchIdx)=YbranchII;
            Cmat=zeros(3);
            Cmat(availablePhases,availablePhases)=eye(length(availablePhases));
            CIndices( jBranchIdx, jnIdx) = Cmat;
            CIndices( jBranchIdx, jmIdx) = -Cmat;
            
    end
end

%% create a connected List of Nodes
connectedPath = gen_path(38, CNodes.', sNodes, rNodes);
connectedPath=[connectedPath,setdiff([1:nBuses],connectedPath)];

%% 6. Adding Ycap [no capacitors]
Ycap=sparse(zeros(size(Ytilde)));

%% Finding available phases
availableBranchIndices=find(any(CIndices,2));
missingBranchIndices=find(~any(CIndices,2));

availableBusAppIndices=find(any(CIndices,1)).';
missingBusAppIndices=find(~any(CIndices,1)).';

availableBusIndices=find(any(Ytilde,2));
missingBusIndices=find(~any(Ytilde,2));

% availableBusAppIndices and availableBusIndices should match

YbusS=Ytilde( availableBusIndices, availableBusIndices);
YcapS=Ycap(availableBusIndices, availableBusIndices);
Ynet=YbusS+YcapS;
Y=Ynet(1:end-3,1:end-3);
Y_NS=Ynet(1:end-3,end-2:end);
Y_SS=Ynet(end-2:end,end-2:end);
Ybus=Y;  % the rank deficient admittance matrix


    
%     if length(phases(ii)) == 3
%         Branch.ThreePhaseBranchNumbers = [Branch.ThreePhaseBranchNumbers;Branch.Numbers(ii)];
%     elseif length(phases{ii}) == 2
%         Branch.TwoPhaseBranchNumbers = [Branch.TwoPhaseBranchNumbers;Branch.Numbers(ii)];
%     else
%         Branch.OnePhaseBranchNumbers = [Branch.OnePhaseBranchNumbers;Branch.Numbers(ii)];
%     end
    
% end
% ConnectedPath  =  gen_path(38, Branch.CNodes.', Branch.BusFromNumbers, Branch.BusToNumbers);
% Branch.ConnectedPath = [ConnectedPath,setdiff([1:numBus],ConnectedPath)];

branchPhaseCode = zeros(numBranch,1);
for i = 1:numBranch
    if all(phases(i,:)==1) % check if all phases are present
        branchPhaseCode(i) = 3;
    end
    if sum(phases(i,:))==2 % check if two phases are present
        branchPhaseCode(i) = 2;
    end
    if sum(phases(i,:))==1 % check if only one phase present
        branchPhaseCode(i) = 1;
    end
end

ThreePhaseBranch = find(branchPhaseCode==3);
TwoPhaseBranch = find(branchPhaseCode==2);
OnePhaseBranch = find(branchPhaseCode==1);

busNames = int16(str2num(cell2mat(busNames)));



