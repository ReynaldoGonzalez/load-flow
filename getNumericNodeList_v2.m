function [ sNodes ] = getNumericNodeList_v2( lineBuses, busNames )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

sNodes=zeros(length(lineBuses),1); 

for jj=1:length(lineBuses)
    
    thisValue = lineBuses(jj);
    idx = find(busNames==thisValue);
    sNodes(jj) = idx; 
    
end



end
