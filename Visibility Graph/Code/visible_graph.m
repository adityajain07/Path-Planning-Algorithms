%%% Author: Aditya Jain %%%
%%% Topic: Visibility Graph for Static Obstacles
%%% Date: 6th February, 2018 %%%
clc
close all
clear
tic
%% Defining environment variables
start = [4,4];     % start position
goal = [90, 85];   % goal position
n = 2;             % no. of obstacles

%% Defining the grid
figure

%%% 1st Config %%%%
% rectangle('Position',[20 10 40 30], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square
% 
% hold on
% rectangle('Position',[50 60 20 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%%%%%%%


%%% 2nd Config
% rectangle('Position',[20 10 40 20], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square
% 
% rectangle('Position',[70 10 20 40], 'FaceColor',[0 .5 .5])
% rectangle('Position',[10 40 40 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[20 70 60 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%


%%% 3rd Config
rectangle('Position',[20 10 20 20], 'FaceColor',[0 .5 .5])
axis([0 100 0 100])
axis square

rectangle('Position',[70 10 20 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[10 40 20 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[20 70 20 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[50 5 15 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[40 40 35 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[10 70 5 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[50 65 20 25], 'FaceColor',[0 .5 .5])
rectangle('Position',[80 35 15 40], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%



% Plotting start position
circles(start(1), start(2),2, 'facecolor','green')

% Plotting goal position
circles(goal(1), goal(2),2, 'facecolor','yellow')

%% initialising the hash map

%%% 1st Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
% values = {start, [20,10], [20,40], [60,40], [60,10], [50,60], [50,80], [70,80], [70,60], goal};
%%%%%%%%%%%%%%%%%

%%% 2nd Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'};
% values = {start, [20,10], [20,30], [60,30], [60,10], [10,40], [10,60], [50,60], [50,40], [70,10], [70,50], [90,50], [90,10], [20,70], [20,90], [80,90], [80,70], goal};
%%%%%%%%%%%%%%%%%

%%% 3rd Config
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'aa', 'ab', 'ac', 'ad', 'ae', 'af', 'ag', 'ah', 'ai', 'aj', 'ak', 'al'};
values = {start, [20,10], [20,30], [40,30], [40,10], [50,5], [50,25], [65,25], [65,5], [70,10], [70,30], [90,30], [90,10], [10,40], [10,60], [30,60], [30,40], [40,40], [40,60], [75,60], [75,40], [80,35], [80,75], [95,75], [95,35], [10,70], [10,90], [15,90], [15,70], [20,70], [20,90], [40,90], [40,70], [50,65], [50,90], [70,90], [70,65], goal};
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


%% Calculating the valid edges and adding them to the graph
ledgeSize = size(edges);
noEdges = ledgeSize(1);

G = graph();

for i = 1:length(2)    
    for j = (i + 1):length(2)        
        % find equation of the edge to be checked
        p1 = values{1,i};
        q1 = values{1,j};
        m1 = (q1(2)-p1(2))/(q1(1)-p1(1));
        c1 = p1(2) - m1*(p1(1));
        %%%%%%%%%%%%
    
        flag = 1;    % flag to check if the edge has any intersection with any other edge;
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
                    flag = 0;
                    break
                end
                %%%%%%
            end

        end
        if flag==1
            G = addedge(G,keys{i}, keys{j});
        end
                
    end    
end

%% Removing the diagonals of the obstacle from the visible edges
length = size(keys);    % this contains the number of nodes
i = 2;

while i < (length(2)-2)
    
    G = rmedge(G,keys{i}, keys{i+2});
    G = rmedge(G,keys{i+1}, keys{i+3});
    i = i + 4;
end

% G = rmedge(G,keys{15}, keys{32});
% G = rmedge(G,keys{14}, keys{33});
% G = rmedge(G,keys{15}, keys{4});
% G = rmedge(G,keys{14}, keys{5});
% G = rmedge(G,keys{10}, keys{25});
% G = rmedge(G,keys{9}, keys{12});

%% Plotting all the visible edges

visEd = G.Edges;  % this has the visible edges
sizeEd = size(G.Edges);

for i=1:sizeEd(1)
   x = visEd(i,1);
   xx = x{1,1};
   p1 = Map(xx{1,1});
   p2 = Map(xx{1,2});
   xpoints = [p1(1,1), p2(1,1)];
   ypoints = [p1(1,2), p2(1,2)];
   hold on
   plot(xpoints, ypoints, 'b')
end

%% finding the shortest path in the graph and printing it 

path = shortestpath(G, keys{1}, keys{length(2)});
pathSize = size(path);

totalDis = 0;    % this will contain the total distance in units for the final selected path

for i=1:pathSize(2)-1
    p1 = Map(path{i});
    p2 = Map(path{i+1});
    
    totalDis = totalDis + EuclDist(p1,p2);
    
    xpoints = [p1(1,1), p2(1,1)];
    ypoints = [p1(1,2), p2(1,2)];
    hold on
    plot(xpoints, ypoints, 'k', 'LineWidth', 3)
    title('Visibility Graph')
end

toc
totalDis
%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
