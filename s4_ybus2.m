%% 5. Create Ytilde and Ybranch
epsilon=1e-5;

% Index for storing the Admittance values
admitIdx = 1:3:numBranch*3;
Admittance = zeros(numBranch*3,5*3); % 3 columns for each Y, Z value

ThreePhaseBranchNumbers=[];
TwoPhaseBranchNumbers=[];
OnePhaseBranchNumbers=[];
RegulatorBranchNumbers=[];
Regs3PhiBranchNumbers=[];
Wye3PhiBranchNumbers=0;
Wye2PhiBranchNumbers=0;
Wye1PhiBranchNumbers=0;
OpenDeltaBranchNumbers=[];
ClosedDeltaBranchNumbers=0;
Wye3PhiTaps=0;
Wye2PhiTaps=0;
Wye1PhiTaps=0;
Wye3PhiAvs=0;
Wye2PhiAvs=0;
Wye1PhiAvs=0;
OpenDeltaTaps=[];
OpenDeltaAvs=[];
ClosedDeltaTaps=[];
ClosedDeltaAvs={};

regulatorTypes = [];

% Phase of each branch
phases = zeros(numBranch,3);

% Traverse the network
for ii = 1:numBranch

    switch LineCodes(ii)
        
        case 3 % 'Reg' % Reg Delta for IEEE 37bus
            
            %configNum = LineConfigs(ii);
            %configNum = sprintf('Config%d',configNum);
            %Zseries = configs.(configNum)(:,1:3);
            %Yshunt = configs.(configNum)(:,4:6);
            
            % Need to get appropriate Zseries from Zcfg
            % In the case of IEEE37 regulator (config 721) is first entry
            
            Zseries = Zcfg(:,:,1);
            Yseries = Ycfg(:,:,1);
            
            % length of the line:
            LineLength=LineLengths(ii);
            AvailablePhases = find(any(Zseries)).';
            
            Zseries = Zseries(AvailablePhases,AvailablePhases);
            Yshunt = Yshunt(AvailablePhases,AvailablePhases);
            
            YNMn = (inv(Zseries*LineLength)/Ybase+0*Yshunt*LineLength/Ybase);
            YNMm = (inv(Zseries*LineLength)/Ybase);
            YMNn = (inv(Zseries*LineLength)/Ybase);
            YMNm = (inv(Zseries*LineLength)/Ybase+0*Yshunt*LineLength/Ybase);
            ZNM = Zseries*LineLength/Zbase;
            
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            Admittance(a:b,1:3) = YNMn;
            Admittance(a:b,4:6) = YNMm;
            Admittance(a:b,7:9) = YMNn;
            Admittance(a:b,10:12) = YMNm;
            Admittance(a:b,13:15) = ZNM;
            
            phases(ii,:) = (branchPhases);
            
            RegulatorBranchNumbers = [RegulatorBranchNumbers;ii];
            
            regulatorTypes=[regulatorTypes;'non-ideal'];
            Regs3PhiBranchNumbers = [Regs3PhiBranchNumbers;ii];
            OpenDeltaBranchNumbers = [OpenDeltaBranchNumbers;ii];
            TapAB = 7;
            TapCB = 4;
            ArAB = 1-0.00625*TapAB;
            ArCB = 1-0.00625*TapCB;
            OpenDeltaTaps = [OpenDeltaTaps,[TapAB; TapCB ]];
            
            Av = [ArAB 1-ArAB 0; 0 1 0; 0 1-ArCB ArCB];
            OpenDeltaAvs = [OpenDeltaAvs;Av];
                       
            clear Zseries LineLength Yshunt YNMn YNMm YMNn YMNm AvailablePhases
                        
        case 5 % 'Switch'
                        
            LineLength = 10; % Length of Switch line:
            
            configNum = LineConfigs(ii);
            configNum = sprintf('Config%i',configNum);
            Zseries = configs.(configNum)(:,1:3);
            Yshunt = configs.(configNum)(:,4:6);
            
            branchPhases = any(Zseries);
            AvailablePhases = find(any(Zseries)).';
            
            Zseries = Zseries(AvailablePhases,AvailablePhases);
            Yshunt = Yshunt(AvailablePhases,AvailablePhases);
            Yseries = inv(Zseries);
            
            % Ytilde
            YNMn = (Yseries/LineLength/Ybase+0*Yshunt*LineLength/Ybase);
            YNMm = (Yseries/LineLength/Ybase);
            YMNn = (Yseries/LineLength/Ybase);
            YMNm = (Yseries/LineLength/Ybase+0*Yshunt*LineLength/Ybase);
            ZNM = Zseries*LineLength/Zbase;
            
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            Admittance(a:b,1:3) = YNMn;
            Admittance(a:b,4:6) = YNMm;
            Admittance(a:b,7:9) = YMNn;
            Admittance(a:b,10:12) = YMNm;
            Admittance(a:b,13:15) = ZNM;
            
            phases(ii,:) = (branchPhases);
            
            clear Zseries LineLength Yshunt YNMn YNMm YMNn YMNm AvailablePhases
   
        case 2 % 'subXFM'
            
            zt   = 0.01*[2+8i]*3;
            yt = 1./zt;
            Y2 =  (1/3) *[ 2*yt, -yt, -yt; -yt,2*yt,-yt; -yt,-yt,2*yt];
            
            Y3 = (1/sqrt(3))*[-yt, yt, 0;
                0, -yt, yt;
                yt, 0, -yt];
            
            Y1 = diag([yt;yt;yt]);
            
            Y2hat1 = Y2+abs(yt)*epsilon*eye(3);
            Y2hat2 = Y2+abs(yt)*(epsilon/2)*eye(3);
            
            % Hard-code for substation transformer
            AvailablePhases = [1;2;3];
            branchPhases = any(AvailablePhases);

            YNMn(AvailablePhases,AvailablePhases) = Y2hat1;
            YNMm(AvailablePhases,AvailablePhases) = Y2hat2;
            YMNn(AvailablePhases,AvailablePhases) = Y2hat2;
            YMNm(AvailablePhases,AvailablePhases) = Y2hat1;
            
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            Admittance(a:b,1:3) = YNMn;
            Admittance(a:b,4:6) = YNMm;
            Admittance(a:b,7:9) = YMNn;
            Admittance(a:b,10:12) = YMNm;
            Admittance(a:b,13:15) = ZNM;
            
            phases(ii,:) = (branchPhases);
            
        case 4 % 'Xfm-1'
            
            zt = 0.01*[0.09+1.81i]*((480/Vbase).^2)*Sbase./(500000);
            yt = 1./zt;
            Y2 =  (1/3) *[ 2*yt, -yt, -yt; -yt,2*yt,-yt; -yt,-yt,2*yt];
            
            %               Y2hat1 = Y2+abs(yt)*epsilon*(100/3)*(1/5)*eye(3);
            %                         Y2hat2 = Y2+abs(yt)*(epsilon/2)*(100/3)*eye(3);
            
            Y2hat1 = Y2+abs(yt)*epsilon*eye(3);
            Y2hat2 = Y2+abs(yt)*(epsilon/2);

            % Hard-code for transformer 1
            AvailablePhases = [1;2;3];
            branchPhases = logical(AvailablePhases');

            
            % Ytilde
            YNMn(AvailablePhases,AvailablePhases) = Y2hat1;
            YNMm(AvailablePhases,AvailablePhases) = Y2hat2;
            YMNn(AvailablePhases,AvailablePhases) = Y2hat2;
            YMNm(AvailablePhases,AvailablePhases) = Y2hat1;
            
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            Admittance(a:b,1:3) = YNMn;
            Admittance(a:b,4:6) = YNMm;
            Admittance(a:b,7:9) = YMNn;
            Admittance(a:b,10:12) = YMNm;
            Admittance(a:b,13:15) = ZNM;
            
            phases(ii,:) = (branchPhases);

        otherwise
            
            LineLength = LineLengths(ii);
            
            Zseries=Zcfg(:,:,lineConfigs(ii));
            Yshunt=Ycfg(:,:,lineConfigs(ii));
            availablePhases=find(any(Zseries));
                       
            branchPhases = any(Zseries);
            AvailablePhases = find(branchPhases).';
            
            % these need work (only works for all 3phase network)
            Zseries = Zseries(AvailablePhases,AvailablePhases);
            Yshunt = Yshunt(AvailablePhases,AvailablePhases);
            Yseries = inv(Zseries);
            
            % Ytilde
            YNMn = (Yseries/LineLength/Ybase+0*Yshunt*LineLength/Ybase);
            YNMm = (Yseries/LineLength/Ybase);
            YMNn = (Yseries/LineLength/Ybase);
            YMNm = (Yseries/LineLength/Ybase+0*Yshunt*LineLength/Ybase);
            ZNM = Zseries*LineLength/Zbase;
            
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            Admittance(a:b,1:3) = YNMn;
            Admittance(a:b,4:6) = YNMm;
            Admittance(a:b,7:9) = YMNn;
            Admittance(a:b,10:12) = YMNm;
            Admittance(a:b,13:15) = ZNM;
            
            phases(ii,:) = (branchPhases);

    end

    
%     if length(phases(ii)) == 3
%         Branch.ThreePhaseBranchNumbers = [Branch.ThreePhaseBranchNumbers;Branch.Numbers(ii)];
%     elseif length(phases{ii}) == 2
%         Branch.TwoPhaseBranchNumbers = [Branch.TwoPhaseBranchNumbers;Branch.Numbers(ii)];
%     else
%         Branch.OnePhaseBranchNumbers = [Branch.OnePhaseBranchNumbers;Branch.Numbers(ii)];
%     end
    
end
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

% QUICK FIX 
if net == 37
    numBus = 37;
end

%test



