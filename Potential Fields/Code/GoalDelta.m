function [delXG, delYG] = GoalDelta(vx, vy, gx, gy, goalR, goalS, alpha)
% This function gives delX, delY of attraction caused by the goal point

dGoal = sqrt((gx-vx)^2 + (gy-vy)^2); % distance bw goal and current position
thetaG = atan2((gy-vy),(gx-vx));     % angle between goal and current position
% delXG = 0; delYG = 0;

if dGoal<goalR
    delXG = 0; delYG = 0;
elseif ((goalS + goalR) >= dGoal) && (dGoal >= goalR)
    delXG = alpha*(dGoal - goalR)*cos(thetaG);
    delYG = alpha*(dGoal - goalR)*sin(thetaG);
else
    delXG = alpha*goalS*cos(thetaG);
    delYG = alpha*goalS*sin(thetaG);
end

end