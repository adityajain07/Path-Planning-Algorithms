% This scripts returns the euclidean distance between two points
function dis = EuclDist(p,q)
    dis  = sqrt(sum((p - q) .^ 2));        
end