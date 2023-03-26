function [branchCurrentsTest] = Compute_Branch_Currents(...
    numBranch,... % DistributionNetwork
    BusFromTo,...
    LineCodes,...
    busIDs,...
    v3Phase,...   % ZBusSolution
    Admittance,...% YBus
    phases,...
    regulatorTypes,...
    RegulatorBranchNumbers,...
    Wye3PhiBranchNumbers,...
    Wye3PhiAvs,...
    Wye2PhiBranchNumbers,...
    Wye2PhiAvs,...
    Wye1PhiBranchNumbers,...
    Wye1PhiAvs,...
    OpenDeltaBranchNumbers,...
    OpenDeltaAvs)
% COMPUTE_BRANCH_CURRENTS
% Inputs are voltage solution, distribution network, and branch information
% Output is the current in A, for each branch

% Device = theDistributionNetwork.LineCodes;
%
% Admittance = theBranches.Admittance;
% Phases = theBranches.Phases;
% RegulatorTypes = theBranches.RegulatorTypes;
% RegulatorBranchNumbers = theBranches.RegulatorBranchNumbers;
% Wye3PhiBranchNumbers = theBranches.Wye3PhiBranchNumbers;
% Wye3PhiAvs = theBranches.Wye3PhiAvs;
% Wye2PhiBranchNumbers = theBranches.Wye2PhiBranchNumbers;
% Wye2PhiAvs = theBranches.Wye2PhiAvs;
% Wye1PhiBranchNumbers = theBranches.Wye1PhiBranchNumbers;
% Wye1PhiAvs = theBranches.Wye1PhiAvs;
% OpenDeltaBranchNumbers = theBranches.OpenDeltaBranchNumbers;
% OpenDeltaAvs = theBranches.OpenDeltaAvs;


% if all(phases(i,:)==1) % check if 3-phases
% if sum(phases(i,:))==2 % check if 2-phases
% if sum(phases(i,:))==1 % check if 1-phase

% store each branch in columns
branchCurrentsTest = complex(zeros(3,numBranch)); % Branch currents complex


% Index for loading the Admittance values
admitIdx = 1:3:numBranch*3;

% try setting up Av for error
Av=zeros(3,3);
n=0;
m=0;
% lineBuses = busIDs(1:end-1);
% busNames=BusFromTo(:,1);
LineBusesFromNumbers = getNumericNodeList_v2(BusFromTo(:,1),busIDs); % you find the location in BusNames of the given index
LineBusesToNumbers = getNumericNodeList_v2(BusFromTo(:,2),busIDs);

for ii=1:numBranch
    n=LineBusesFromNumbers(ii);
    m=LineBusesToNumbers(ii);
    PhaseSet=phases(ii);
    PhaseSet = [1;2;3;];%FIX
    switch LineCodes(ii)
        
        case 3 % 'Reg'
            r=find(RegulatorBranchNumbers==ii);% which regulator number it is
            RegulatorType=regulatorTypes(r); % regulatorTypes is a 1x1 cell array with 'OpenDelta' type, but is not longer cell array due to simulink changes
            % overall want OpenDelta so hardcode here:
            RegulatorType = 'OpenDelta';
            switch char(RegulatorType)
                case 'Wye' % We don't have WYE in IEEE 37
                    
                    a = admitIdx(ii);
                    b = admitIdx(ii)+2;
                    AdmittanceYNMn = Admittance(a:b,1:3);
                    AdmittanceYNMm = Admittance(a:b,4:6);
                    AdmittanceYMNn = Admittance(a:b,7:9);
                    AdmittanceYMNm = Admittance(a:b,10:12);
                    
                    if all(phases(ii,:)==1) % check if 3-phases
                        rrr=find(Wye3PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye3PhiAvs(rrr);
                    elseif sum(phases(ii,:))==2 % check if 2-phases
                        rrr=find(Wye2PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye2PhiAvs(rrr);
                    else
                        rrr=find(Wye1PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye1PhiAvs(rrr);
                    end
                    branchCurrentsTest(:,ii)=((inv(Av.')*  AdmittanceYNMn*inv(Av)*(v3Phase(n,PhaseSet).')-...
                        inv(Av.')* AdmittanceYNMm*(v3Phase(m,PhaseSet).')));
                    
                case 'ClosedDelta' %We don't have ClosedDelta in IEEE37
                    
                    a = admitIdx(ii);
                    b = admitIdx(ii)+2;
                    AdmittanceYNMn = Admittance(a:b,1:3);
                    AdmittanceYNMm = Admittance(a:b,4:6);
                    AdmittanceYMNn = Admittance(a:b,7:9);
                    AdmittanceYMNm = Admittance(a:b,10:12);
                    
                    if all(phases(ii,:)==1) % check if 3-phases
                        rrr=find(Wye3PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye3PhiAvs(rrr);
                    elseif sum(phases(ii,:))==2 % check if 2-phases
                        rrr=find(Wye2PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye2PhiAvs(rrr);
                    else
                        rrr=find(Wye1PhiBranchNumbers==ii); % which 3Phi regulator number it is
                        Av=Wye1PhiAvs(rrr);
                    end
                    branchCurrentsTest(:,ii)=((inv(Av.')*  AdmittanceYNMn*inv(Av)*(v3Phase(n,PhaseSet).')-...
                        inv(Av.')* AdmittanceYNMm*(v3Phase(m,PhaseSet).')));
                    
                case 'OpenDelta'
                    
                    a = admitIdx(ii);
                    b = admitIdx(ii)+2;
                    AdmittanceYNMn = Admittance(a:b,1:3);
                    AdmittanceYNMm = Admittance(a:b,4:6);
                    AdmittanceYMNn = Admittance(a:b,7:9);
                    AdmittanceYMNm = Admittance(a:b,10:12);
                    
                    if all(phases(ii,:)==1) % check if 3-phases
                        rrr=find(OpenDeltaBranchNumbers==ii); % which 3Phi regulator number it is
%                         Av=OpenDeltaAvs(rrr);
                        Av = OpenDeltaAvs; % prev was 1x1 cell; is now 3x3 mat
                    elseif sum(phases(ii,1:3))==2 % check if 2-phases
                        rrr=find(OpenDeltaBranchNumbers==ii); % which 3Phi regulator number it is
%                         Av=OpenDeltaAvs(rrr);
                        Av = OpenDeltaAvs; % prev was 1x1 cell; is now 3x3 mat
                    else
                        rrr=find(OpenDeltaBranchNumbers==ii); % which 3Phi regulator number it is
%                         Av=OpenDeltaAvs(rrr);
                        Av = OpenDeltaAvs; % prev was 1x1 cell; is now 3x3 mat
                    end
                    branchCurrentsTest(:,ii)=((inv(Av.')*AdmittanceYNMn*inv(Av)*(v3Phase(n,PhaseSet).')-...
                        inv(Av.')* AdmittanceYNMm*(v3Phase(m,PhaseSet).')));
                    

            end
        otherwise
            a = admitIdx(ii);
            b = admitIdx(ii)+2;
            AdmittanceYNMn = Admittance(a:b,1:3);
            AdmittanceYNMm = Admittance(a:b,4:6);
            AdmittanceYMNn = Admittance(a:b,7:9);
            AdmittanceYMNm = Admittance(a:b,10:12);
            
            branchCurrentsTest(:,ii)=((AdmittanceYNMn*(v3Phase(n,PhaseSet).')-...
                AdmittanceYNMm*(v3Phase(m,PhaseSet).')));
            
    end
end
% branchCurrents = branchCurrents';
% branchCurrents = reshape(branchCurrents,3,numBranch).';
end