%% FUNCTION 1
[Y,Ybus,Ybranch_array,Y_NS,Y_SS,N,ABI,MBI,PNLI,CNodes,CIndices,regulator] = Create_Ybus(...
                        numBus,busNames,lineBuses1,lineBuses2,LineCodes,...
                        lineStatuses,LineLengths,lineConfigs,...
                        Zcfg,Ycfg,Ybase,Vbase,Sbase,epsilon,regulatorTypes,regulator);

% N=9;
% Convert all cell arrays to arrays
regulator.VoltageGains = cell2mat(regulator.VoltageGains);
regulator.CurrentGains = cell2mat(regulator.CurrentGains);
regulator.Impedances = cell2mat(regulator.Impedances);
regulator.YNMn = cell2mat(regulator.YNMn);
regulator.YNMm = cell2mat(regulator.YNMm);

%% FUNCTION 2
noLoadQuantities = Compute_No_Load_Voltage(Y,Y_NS,N, ...
                                           ABI,MBI, ...
                                           [1;1;1], [0; -120; 120]);

%% FUNCTION 3

Y = full(Y);
Ybus = full(Ybus);
Y_NS = full(Y_NS);

distNet.Y = full(Y);
distNet.Ybus = full(Ybus);
distNet.Y_NS = full(Y_NS);
distNet.N = N;
distNet.ABI = ABI;
distNet.MBI = MBI;
distNet.PNLI = PNLI;
% distNet.regulator = regulator;
% distNet.noLoadQuantities = noLoadQuantities;
% distNet.loadQuantities = loadQuantities;

% fix empty MBI error
if isempty(MBI)
    MBI = 0;
end

busNames = int16(str2num(cell2mat(busNames)));

% clearvars -except loadQuantities N Y Y_NS ABI MBI ... % H
%     busIDs regulator noLoadQuantities
% end

FromBus = lineBuses1;
ToBus = lineBuses2;
for i = 1:length(LineCodes)
    LineConfigs(i) = str2num(string(LineCodes(i,:)));
end

% line codes
% 0=overhead-line; 
% 1=transformer; 
% 2=substation-transformer
% 3=regulator
% 4=transformer-1 (IEEE37)
% 5=switch


if net == 9
    LineCodes = [0 0 0 0 0 0 0 0 2]';
elseif net == 37
    LineCodes = zeros(37,1);
    LineCodes(35) = 4;
    LineCodes(36) = 3;
    LineCodes(37) = 2;
end

BusNames = unique([FromBus;ToBus]);

busTo = cellfun(@str2num,ToBus);
busFrom = cellfun(@str2num,FromBus);

BusFromTo = [busFrom busTo];

