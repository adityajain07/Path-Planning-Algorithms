% This script checks if two line segments intersect
% Used to check intersection between qnew and qnear with all obstacle edges
% returns 1 if no intersection
function t = CheckIntersection(qnear,qnewtemp,edges)

    ledgeSize = size(edges);
    noEdges = ledgeSize(1);
    
       
                
        % find equation of line between qnear and qnewtemp
        p1 = qnear;
        q1 = qnewtemp;
        m1 = (q1(2)-p1(2))/(q1(1)-p1(1));
        c1 = p1(2) - m1*(p1(1));
        %%%%%%%%%%%%
    
        t = 1;    % flag to check if the edge has any intersection with any other edge;
                     % '1' means no intersection
        % need to compare with the edges   
        for k = 1:noEdges            
            ed = edges(k,:);            
            m2 = (ed(4) - ed(3))/(ed(2) - ed(1));
            if(ed(2)==ed(1))
                m2 = 1e+10;
            end
            c2 = ed(3) - m2*ed(1);  
            
            if m1==m2 %% ignoring 
                t = 1;
            else
                
                %%%%%%
                temp1 = ed(3) - m1*ed(1) - c1;
                temp2 = ed(4) - m1*ed(2) - c1;
                
                temp3 = p1(2) - m2*p1(1) - c2;
                temp4 = q1(2) - m2*q1(1) - c2;
                
                if (sign(temp1) ~= sign(temp2)) &&  sign(temp1)~=0 && sign(temp2)~=0 && (sign(temp3) ~= sign(temp4)) &&  sign(temp3)~=0 && sign(temp4)~=0
                    t = 0;
                    break
                end
                %%%%%%
            end

        end     
end