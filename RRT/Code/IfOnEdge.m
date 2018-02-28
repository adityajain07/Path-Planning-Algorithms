% This script checks if the new node to be added is not lying on any of
% the obstacle edges
function res = IfOnEdge(p,edges)

        ledgeSize = size(edges);
        noEdges = ledgeSize(1);
        
        for k = 1:noEdges            
            ed = edges(k,:);            
            m = (ed(4) - ed(3))/(ed(2) - ed(1));
            if(ed(2)==ed(1))
                m = 1e+10;
            end
            c = ed(3) - m*ed(1); 
            
            res = p(1,2) - m*p(1,1) - c;
            
            if (res == 0)
                break
            end
            
        end

end