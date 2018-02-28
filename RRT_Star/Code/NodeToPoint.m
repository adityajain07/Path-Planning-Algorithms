% This function returns the graph node (which is in cell format) to a
% number array to be used for distance calculations and stuff

function p = NodeToPoint(n)    
    temp = char(n);
    temp2 = strsplit(temp,'\');
    tempx = temp2{1,1};
    tempy = temp2{1,2};
    p = [str2num(tempx), str2num(tempy)];
end