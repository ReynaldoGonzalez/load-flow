function [ solution ] = Obtain_Voltages(...
    busIDs,...
    noLoadQuantities,...
    N,ZBusResults,...
    regulatorTypes,regulator)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

% v2struct(network);
% v2struct(noLoadQuantities);
% v2struct(loadQuantities);
% v2struct(ZBusResults);

% sL_load = loadQuantities.sL_load;
% iL_load = loadQuantities.iL_load;
% yL_load = loadQuantities.yL_load;
% ePage = loadQuantities.ePage;
% gMat = loadQuantities.gMat;
% cMat = loadQuantities.cMat;
% YL = loadQuantities.YL;

v0mags = noLoadQuantities.v0mags;
v0phases = noLoadQuantities.v0phases;
v0 = noLoadQuantities.v0;
w = noLoadQuantities.w;
wCheck = noLoadQuantities.wCheck;
w3phase = noLoadQuantities.w3phase;

v = ZBusResults.v;
vsol = ZBusResults.vsol;
success = ZBusResults.success;
err = ZBusResults.err;

regulatorVoltageGains = regulator.VoltageGains;
regulatorCurrentGains = regulator.CurrentGains;
regulatorImpedances = regulator.Impedances;
regulatorYNMn = regulator.YNMn;
regulatorYNMm = regulator.YNMm;

% availableBusIndices = ABI;

v3phase=reshape(v,3,N+1).';

% adding n' of the regulators to the labels:
v3phaseRegs=complex(NaN(1,3));

regIdx = find(busIDs==799);
regIdx2 = find(busIDs==701);
if strcmp(regulatorTypes,'ideal')
    v3phaseRegs(1,:)=(inv(regulatorVoltageGains(1))*v3phase(regIdx,:).').'; % three phases
else
    v3phaseRegs(1,:)=(inv(regulatorVoltageGains(1))*(v3phase(regIdx,:).'...
        -regulatorImpedances(1)*inv(regulatorCurrentGains(1))*(regulatorYNMn(1)*v3phase(regIdx,:).'-regulatorYNMm(1)*v3phase(regIdx2,:).'))).';
end

resultsVMag=[abs(v3phase);abs(v3phaseRegs)];
resultsVPhase=[radian2degrees(angle(v3phase)); radian2degrees(angle(v3phaseRegs))];

%%

% solution=v2struct(resultsVMag,resultsVPhase, v3phase,v3phaseRegs, err,success);
solution = v3phase;

end

