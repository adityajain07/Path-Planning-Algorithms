% This function returns the new point along the line joining qnearest and
% qrandom, with step size away from qnear

function p = NewPointonLine(qnear,qrand,step)
        v = qrand - qnear;
        u = v/norm(v);
        p = qnear + step*u;
end