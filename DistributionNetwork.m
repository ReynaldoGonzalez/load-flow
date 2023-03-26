classdef DistributionNetwork
    properties
        NumBus
        NumBranch
        BusFromTo
        LineLengths
        LineConfigs
        LineCodes
        SBase
        VBase
        ZBase
        YBase
    end
    
    methods
        function obj = DistributionNetwork(numBus,numBranch,busFromTo,...
                                           lineLengths,lineConfigs,lineCodes,...
                                           Sbase,Vbase,Zbase,Ybase)
            obj.NumBus = numBus;
            obj.NumBranch = numBranch;
            obj.BusFromTo = busFromTo;
            obj.LineLengths = lineLengths;
            obj.LineConfigs = lineConfigs;
            obj.LineCodes = lineCodes;
            obj.SBase = Sbase;
            obj.VBase = Vbase;
            obj.ZBase = Zbase;
            obj.YBase = Ybase;
        end
    end
end