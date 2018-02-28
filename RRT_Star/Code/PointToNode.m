% This function converts an (x,y) coordinate point in an array to a string which can be
% then added as a node in the graph for RRT
function n = PointToNode(p)    
    temp1 = num2str(p(1,1));
    temp2 = num2str(p(1,2));
    n = strcat(temp1,'\',temp2);   % & is to differentiate between the x and y coordinate
end