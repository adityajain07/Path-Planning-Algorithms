% This script returns the node to which we have to connect for minimum cost
% to the start node

function minNode = MinCostNode(G,q,vic,start,qnear)
       sizeG = size(G.Nodes);       
       minCost = 1e+10;         % min distance
       minNode = qnear;         % initialising
       for i=1:sizeG(1,1)    % length of number of nodes in the graph
        temp = G.Nodes{i,1};    
        point = NodeToPoint(temp);

        if (EuclDist(q,point) <= vic)
               path = shortestpath(G, PointToNode(start), temp);
               pathSize = size(path);

                totalDis = 0;
                for j=1:pathSize(2)-1
                    t1 = path{j};
                    t2 = path{j+1};
    
                    p1 = NodeToPoint(t1);
                    p2 = NodeToPoint(t2);
                    totalDis = totalDis + EuclDist(p1,p2);
    
                end 
            cost = totalDis + EuclDist(q,point);
            
            if (cost < minCost)
                minCost = cost;
                minNode = point;
            end
        end       
        
       end
end