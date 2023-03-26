function [ ZBusResults ] = Perform_ZBus(...
    noLoadQuantities,...
     sL_load,iL_load,yL_load,ePage,gMat,cMat,YL,...
    N,Y,Y_NS,ABI,MBI)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

persistent vNew

maxIt=10;

% v2struct(network);
% v2struct(noLoadQuantities);
% v2struct(loadQuantities);

if isempty(vNew)
    vNew = 0;
end

% sL_load = loadQuantities.sL_load;
% iL_load = loadQuantities.iL_load;
% yL_load = loadQuantities.yL_load;
% ePage = loadQuantities.ePage;
% gMat = loadQuantities.gMat;
% cMat = loadQuantities.cMat;
% YL = loadQuantities.YL;

% Unpack noLoadquantities
v0mags = noLoadQuantities.v0mags;
v0phases = noLoadQuantities.v0phases;
v0 = noLoadQuantities.v0;
w = noLoadQuantities.w;
wCheck = noLoadQuantities.wCheck;
w3phase = noLoadQuantities.w3phase;

availableBusIndices = ABI;
missingBusIndices = MBI;

vPr=repmat(v0,N+1,1);
vPr=vPr(availableBusIndices(1:end-3));

success=0;
maxIt=10;

err = inf+zeros(maxIt+1,1);

vIterations = complex(zeros(size(vPr,1),maxIt+1));
vIterations(:,1) = vPr;

fv_test = calculateIPQII(vPr, gMat, cMat, ePage, sL_load,iL_load,yL_load );

err(1) = sum(abs((Y+YL)*vPr+fv_test+Y_NS*v0));
errStr = sprintf('%f', err(1));
iterMessage = ['Iteration No. ', num2str(0),' Error is ', errStr];
fprintf('%s \n', iterMessage);
for it=1:maxIt
    
    if err(it) <1e-5
        itSuccess=it-1;
        fprintf('Convergence \n');
        success=1;
        break;
    end

    vNew = inv(Y+YL)*(-fv_test-Y_NS*v0);
    vIterations(:,it+1) = vNew;
    vPr = vNew;
    fv_test = calculateIPQII(vPr, gMat, cMat, ePage, sL_load,iL_load,yL_load );
    err(it+1) = sum(abs((Y+YL)*vNew+fv_test+Y_NS*v0));
    iterStr = sprintf('%f', it);
    errStr = sprintf('%f', err(it+1));
    iterMessage = ['Iteration No. ', iterStr,' Error is ', errStr];
    fprintf('%s \n', iterMessage);
end

vsol = vNew;

vsol = [vsol;v0];
v = complex(zeros(3*(N+1),1));

v(availableBusIndices,1) = vsol;

% fix empty MBI error
if MBI ~= 0
    v(missingBusIndices,1) = NaN;
end

% ZBusResults = v2struct(v, vsol, success, err);
ZBusResults.v = v;
ZBusResults.vsol = vsol;
ZBusResults.success = success;
ZBusResults.err = err;

end

