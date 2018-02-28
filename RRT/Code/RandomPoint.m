% This function generates the random point in the grid with the nth random
% point to be always the goal position

function p = RandomPoint(g,i,goalPos)
        % g is the gth point generated will be the goal position
        % i is the iterator to check the above
        % goalPos has the goal position to be returned
        if (mod(i,g)==0)
            p = goalPos;
        else
            p = randi([1 100],1,2);
        end

end