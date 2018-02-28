% Given input a graph and a random point in the grid, this script returns
% the nearest node in the graph to that point
function n = NearestNode(G,q)
       sizeG = size(G.Nodes);       
       dmin = 1e+10;         % min distance
       
       for i=1:sizeG(1,1)    % length of number of nodes in the graph
        temp = G.Nodes{i,1};    
        point = NodeToPoint(temp);
%         D  = sqrt(sum((q - point) .^ 2));
        D = EuclDist(q,point);
        
        if (D<dmin)
            dmin = D;
            n = point;            
        end
        
       end
end