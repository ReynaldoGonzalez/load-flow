import_cyme_loads;
for i = 1:width(spotloads)
    cyme_loads{i} = table2cell(spotloads(:,i));
end

loadBusesStr = cyme_loads{:,1};
for i = 1:height(spotloads)
    loadBuses(i) = str2double(loadBusesStr{i});
end
loadTypes = cyme_loads{:,2};

loadQuantities = Setup_Loads_v2(loadBuses,loadTypes,cyme_loads,N,busNames,Sbase,noLoadQuantities,ABI,PNLI);

% loadQuantities = Setup_Loads_CYME(loads,N,busNames,Sbase,noLoadQuantities,ABI,PNLI);


%% dummy 

% % change loadType to string AFTER running setup_loads
% loadTypes = string(loadTypes);
% 
% % first column is bus IDs
% % second column is load typs
% for i = 1:6 % there should be 6 values per load
%     loadsDummy(:,i) = cyme_loads{i+2};
% end
% loadsDummy = cell2mat(loadsDummy);
% loadsIn = loadsDummy;
% 
% % Bus to numeric
busNames = int16(str2num(cell2mat(busNames)));


RegulatorBranchNumbers=0;
OpenDeltaBranchNumbers=0;
OpenDeltaAvs=0;
