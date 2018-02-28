# About 
This project implements the algorithm of RRT*.

## Rewiring
Two types of rewiring happens in RRT*, in addition to the standard RRT: <br />
qrand: randomly chosen point in the environment  <br />
qnear: nearest node to qrand                      <br />
qnew: new node in the direction of qrand and step size 's' from qnear   <br />
1. After qnew has been found, it is not connected to qnear unlike in RRT. All the nodes in neighbourhood (specified radius) of qnew is checked; the one which gives the shortest path from qnew to the start node is chosen. qnew is connected to this node.
2. After the above connection and again in the same neighbourhood of qnew, the path from start to all these neighbour nodes is calculated. If this path is more than the path from start to qnew and from qnew to the node, then the parent of this neighbour node is removed and qnew is made the new parent. <br />
<br />
The algorithm has been borrowed from this paper: https://arxiv.org/pdf/1704.04585.pdf <br />

Note: Only the first rewiring has been implemented till now.

## Points to Note
1. The obstacles have been deterministically placed in the environment
2. Shortest path in the graph is calculated using BFS
3. The code also outputs total path length in unit distance and time taken to execute the code


## Path: 1st Environment
Green circle: start position  <br />
Yellow circle: goal position  <br />
![alt text](https://github.com/adityajain07/Path-Planning-Algorithms/blob/master/RRT_Star/Plots/RRTstar_Conf1.png)




## Path: 2nd Environment
![alt text](https://github.com/adityajain07/Path-Planning-Algorithms/blob/master/RRT_Star/Plots/RRTstar_Conf2.png)




## Path: 3rd Environment
![alt text](https://github.com/adityajain07/Path-Planning-Algorithms/blob/master/RRT_Star/Plots/RRTstar_Conf3.png)
