function [delXO, delYO] = ObsDelta(vx, vy, ox, oy, obsRad, obsS, beta)
% This function gives delX, delY of repulsion caused by the obstacle

inf = 10;
dObs = sqrt((ox-vx)^2 + (oy-vy)^2); % distance bw goal and current position
thetaO = atan2((oy-vy),(ox-vx));     % angle between goal and current position
% delXO = 0; delYO = 0;

if dObs<obsRad
    delXO = -(sign(cos(thetaO)))*inf;
    delYO = -(sign(sin(thetaO)))*inf;
elseif (dObs < (obsS + obsRad)) && (dObs>=obsRad)
    delXO = -beta*(obsS + obsRad - dObs)*cos(thetaO);
    delYO = -beta*(obsS + obsRad - dObs)*sin(thetaO);
else 
    delXO = 0;
    delYO = 0;
end

end