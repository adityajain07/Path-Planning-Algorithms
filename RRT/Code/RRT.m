%%% Author: Aditya Jain %%%
%%% Topic: RRT for Static Obstacles
%%% Date: 10th February, 2018 %%%
clc
close all
clear
tic

%% Defining environment variables
start = [4,4];     % start position
goal = [90, 85];   % goal position
n = 2;             % no. of obstacles

%% Defining the grid

% %%%% 1st Config %%%%%%
figure
rectangle('Position',[20 10 40 30], 'FaceColor',[0 .5 .5])
axis([0 100 0 100])
axis square
title('RRT Path Planning Algorithm')

% hold on
rectangle('Position',[50 60 20 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%%%%%%%%%


% 2nd Config
% figure
% rectangle('Position',[20 10 40 20], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square
% title('RRT Path Planning Algorithm')
% 
% rectangle('Position',[70 10 20 40], 'FaceColor',[0 .5 .5])
% rectangle('Position',[10 40 40 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[20 70 60 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%


%%% 3rd Config
% rectangle('Position',[20 10 20 20], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square
% 
% rectangle('Position',[70 10 20 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[10 40 20 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[20 70 20 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[50 5 15 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[40 40 35 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[10 70 5 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[50 65 20 25], 'FaceColor',[0 .5 .5])
% rectangle('Position',[80 35 15 40], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%

% Plotting start position
circles(start(1), start(2),2, 'facecolor','green')

% Plotting goal position
circles(goal(1), goal(2),2, 'facecolor','yellow')

%% initialising the hash map
%%% 1st Config
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
values = {start, [20,10], [20,40], [60,40], [60,10], [50,60], [50,80], [70,80], [70,60], goal};
%%%%%%%%%%%%%%%%%

%%% 2nd Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'};
% values = {start, [20,10], [20,30], [60,30], [60,10], [10,40], [10,60], [50,60], [50,40], [70,10], [70,50], [90,50], [90,10], [20,70], [20,90], [80,90], [80,70], goal};
% %%%%%%%%%%%%%%%%%

%%% 3rd Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'aa', 'ab', 'ac', 'ad', 'ae', 'af', 'ag', 'ah', 'ai', 'aj', 'ak', 'al'};
% values = {start, [20,10], [20,30], [40,30], [40,10], [50,5], [50,25], [65,25], [65,5], [70,10], [70,30], [90,30], [90,10], [10,40], [10,60], [30,60], [30,40], [40,40], [40,60], [75,60], [75,40], [80,35], [80,75], [95,75], [95,35], [10,70], [10,90], [15,90], [15,70], [20,70], [20,90], [40,90], [40,70], [50,65], [50,90], [70,90], [70,65], goal};
%%%%%%%%%%%%%%%%%

Map = containers.Map(keys, values);
len = Map.values;
Map('j');



%% Building all the obstacle edges
length = size(keys);    % this contains the number of nodes

edges = [];

for i = 2:(length(2)-2)   
        temp = [values{1,i}(1), values{1,i+1}(1), values{1,i}(2), values{1,i+1}(2)];
        edges = vertcat(edges, temp);                
end


% Removing edges which are not obstacle edges
sizeEdges = size(edges);
i = 4;
while i < (sizeEdges(1)-1)
    [edges,ps] = removerows(edges,'ind',i);
    sizeEdges = size(edges);
    i = i + 3;
end

% Adding 1 edge pair in each obstacle which were not added in the earlier
% for loop
i = 2;
while i < length(2)-2    
    temp = [values{1,i}(1), values{1,i+3}(1), values{1,i}(2), values{1,i+3}(2)];
    edges = vertcat(edges, temp);
    i = i + 4;    
end
%% RRT Algorithm
G = graph;                      % initialising the graph
step = 2;                       % step size for the RRT algo
qinit = start;                  % initialising the first node of the graph
qnew = PointToNode(qinit);      % latest added node in the graph
G = addnode(G, qnew);           % adding the node to the graph
flag = 1;                       % flag to terminate RRT
ranG = 7;                       % every ranGth point will be the goal position in the random function script
i = 0;                          % iterator used to pick every ranGth point as goal position

while (flag==1)
    i = i + 1;
    
    qrand = RandomPoint(ranG,i,goal);             % generating the random point on the grid
    qnear = NearestNode(G,qrand);                 % nearest node to qrand in the form of array
    qnewtemp = round(NewPointonLine(qnear,qrand,step));  % the new point along the line with a step distance
    ch = IfOnEdge(qnewtemp,edges);
    
    if (ch ~= 0)  % If not lying on any of the edges, then proceed further
     check = CheckIntersection(qnear,qnewtemp,edges);    % 1 means no intersection
    
    if (check==1)
        
        if (findnode(G,PointToNode(qnewtemp))) == 0   % to check if node already exists in the graph
            G = addnode(G, PointToNode(qnewtemp));
        end
        
        if (findedge(G,PointToNode(qnear),PointToNode(qnewtemp)))==0  % to check if edge exists in the graph
            G = addedge(G,PointToNode(qnear), PointToNode(qnewtemp));            
        end
        
        qnew = qnewtemp;
        % plot the edge
        xpoints = [qnear(1,1), qnew(1,1)];
        ypoints = [qnear(1,2), qnew(1,2)];        
        hold on
        plot(xpoints, ypoints, 'b')
        %%%
        
        % checking distance with the goal position
        if (EuclDist(qnew,goal) <= step)
            G = addedge(G,PointToNode(qnew), PointToNode(goal));
            flag = 0;   % terminating the expansion of tree
        end
        
    end
    
    end
    
%     break
end

%% find the shortest path from the graph generated from RRT

path = shortestpath(G, PointToNode(start), PointToNode(goal));
pathSize = size(path);

totalDis = 0;

for i=1:pathSize(2)-1
    t1 = path{i};
    t2 = path{i+1};
    
    p1 = NodeToPoint(t1);
    p2 = NodeToPoint(t2);
    totalDis = totalDis + EuclDist(p1,p2);
    
    xpoints = [p1(1,1), p2(1,1)];
    ypoints = [p1(1,2), p2(1,2)];
    hold on
    plot(xpoints, ypoints, 'k', 'LineWidth', 3) 
    title('RRT Path Planning Algorithm')
end
totalDis
toc
%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
