function [branchCurrentsTest] = Compute_Branch_Currents_alt(...
    numBranch,... % DistributionNetwork
    BusFromTo,...
    LineCodes,...
    busIDs,...
    v3phase,...   % ZBusSolution
    Admittance)
% COMPUTE_BRANCH_CURRENTS
% Inputs are voltage solution, distribution network, and branch information
% Output is the current in A, for each branch

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

for ii = 1:numBranch
    n = LineBusesFromNumbers(ii);
    m = LineBusesToNumbers(ii);
    %PhaseSet = phases(ii);
    PhaseSet = [1;2;3;];%FIX

    a = admitIdx(ii);
    b = admitIdx(ii)+2;
    AdmittanceYNMn = Admittance(a:b,1:3);
    AdmittanceYNMm = Admittance(a:b,4:6);
    AdmittanceYMNn = Admittance(a:b,7:9);
    AdmittanceYMNm = Admittance(a:b,10:12);
    
    % try -YNMn (YNMm)
    branchCurrentsTest(:,ii) = ((AdmittanceYNMn*(v3phase(n,PhaseSet).')-AdmittanceYNMn*(v3phase(m,PhaseSet).')));

end
% branchCurrents = branchCurrents';
% branchCurrents = reshape(branchCurrents,3,numBranch).';
end