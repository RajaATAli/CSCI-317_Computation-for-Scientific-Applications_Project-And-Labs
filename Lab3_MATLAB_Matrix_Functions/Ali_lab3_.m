% CSCI-317 Lab 3 - MatLab Matrix and Function
% ------------------------------------
% Problem Description: 
% * This program finds the shortest distance between two cities in Southern
% Ontario that do not have a direct flight/connection, using Dijkstra's
% Algorithm
% * The algorithm operates by choosing the vertex (city) with the minimum 
% distance, updating the distance of its neighbors, and repeating the
% process until all vertices have been visited. 
% * This ensures the shortest distance to each city from the starting point
% is found.
% * Solving this problem is useful for planning travel routes, allowing 
% users to find the most efficient path in terms of distance.
% --------------------------------------
% Author: Raja Allmdar Tariq Ali
% Date: 02/11/24
% --------------------------------------


% Matrix representing data from Southern Ontario Distance Chart in Km 
% (1 Km = 0.6 miles)
% Brantford to Kitchener-Waterloo
distances = [
    0, 234, 70, 149, 155, 144, 39, 39;
    234, 0, 110, 282, 176, 220, 200, 140;
    70, 110, 0, 208, 128, 149, 76, 30;
    149, 282, 208, 0, 282, 316, 95, 166;
    115, 175, 128, 282, 0, 49, 172, 115;
    144, 220, 149, 316, 49, 0, 186, 105;
    39, 200, 76, 95, 172, 186, 0, 64;
    39, 140, 30, 166, 115, 105, 64, 0
];


% Main Program Logic
% Collect user inputs for start and end cities and convert them to indices

% Define a mapping of city names to indices
cityNames = {'Brantford', 'Collingwood', 'Elora', 'Fort Erie', 'Goderich', 'Grand Bend', 'Hamilton', 'Kitchener-Waterloo'};
cityMap = containers.Map(cityNames, 1:length(cityNames));

% Travelling Menu Display
% Get user input for start and end cities
[startCity, endCity] = getUserInput(cityNames, cityMap);


% Call the Dijkstra's algorithm function with the distance matrix and city indices
[shortestDistance, pathIndices] = dijkstraAlgorithm(distances, startCity, endCity);

% Convert path indices back to city names
if isequal(pathIndices, 'No path found')
    pathNames = pathIndices;
else
    pathNames = cell(1, length(pathIndices)); % Initialize an empty cell array for path names
    for i = 1:length(pathIndices)
        pathNames{i} = cityNames{pathIndices(i)}; % Convert each index to its corresponding city name
    end
end

% Display the shortest distance and the path to the user
fprintf('\nThe shortest distance from %s to %s is: %.1f km\n', cityNames{startCity}, cityNames{endCity}, shortestDistance);
if iscell(pathNames) % If pathNames is a cell array, a path was found
    fprintf('Path: %s\n', strjoin(pathNames, ' -> '));
else
    fprintf('%s\n', pathNames); % If pathNames is not a cell array, it's the 'No path found' message
end


% User-Defined Function to handle user input
function [startCity, endCity] = getUserInput(cityNames, cityMap)
    fprintf('Welcome to Ontario Pathfinder!\n');
    fprintf('Below are the cities available for your journey:\n\n');
    
    % For loop to display each of the city names
    for i = 1:length(cityNames)
        fprintf('%d. %s\n', i, cityNames{i});
    end
    
    fprintf('\nPlease enter the names of your start and end cities exactly as shown above.\n');
    
    startCityName = input('Enter the name of the start city: ', 's');
    endCityName = input('Enter the name of the end city: ', 's');
    
    startCity = cityMap(startCityName);
    endCity = cityMap(endCityName);
end



% User-Defined function for Dijkstra's algorithm
% Implement Dijkstra's algorithm here
% Output the shortest distance and the path taken
function [shortestDistance, pathIndices] = dijkstraAlgorithm(distMatrix, startCity, endCity)
    % 1. Initialize variables to keep track of visited nodes, the shortest
    % distance discovered (infinity for all nodes except the start/source 
    % node which is zero), and an array to remember predecessors of each 
    % node for path reconstruction

    % Number of cities - which are all the nodes
    %distMatrix(i,j) is the distance from city 'i' to city 'j'
    % The following function returns the total number of rows in the matrix
    numCities = size(distMatrix, 1);

    % Creating an array of false logical values which represents that
    % initially no city has been visited
    visited = false(1, numCities);

    % Setting all distances to initially infinity in array
    % This array will be used to store the shortest known distance from the
    % start city to every other city
    distance = inf(1, numCities);

    % previous tracks the previous node in the optimal path from start city
    prev = -ones(1, numCities); % Initialize with -1 for no predecessor
    
    % Setting the distance of the start city to 0
    distance(startCity) = 0;
    
    % This part is used for node selection -  smallest distance from the 
    % start node
    for i = 1:numCities
        % Find the unvisited node with the smallest distance
        minDistance = inf; % Represents smallest distance found in the iteration
        u = -1; % Index of node of smallest distance
        % Iterating through all nodes
        for j = 1:numCities
            if ~visited(j) && distance(j) <= minDistance
                % Update the distance and index of the node
                minDistance = distance(j);
                u = j;
            end
        end
        
        % If no node was found (isolated or remaining nodes are unreachable), break the loop
        if u == -1
            break;
        end
        
        visited(u) = true;
        
        % If the destination node is reached, break the loop
        if u == endCity
            break;
        end
        
        % Update the distance for each neighbor of u
        % Relaxation is a key concept here:
        % if (d[u] + c(u,v) < d[v])
        % d[v] = d[u] + c(u,v)
        for v = 1:numCities
            if distMatrix(u, v) > 0 && ~visited(v)
                alt = distance(u) + distMatrix(u, v);
                if alt < distance(v)
                    distance(v) = alt;
                    prev(v) = u;
                end
            end
        end
    end
    
    % Reconstruct path and calculate shortest distance
    if distance(endCity) == inf
        shortestDistance = inf;
        pathIndices = 'No path found';
    else
        % We essentially trace back through the previous array
        shortestDistance = distance(endCity);
        pathIndices = [];
        u = endCity;
        while u ~= -1
            pathIndices = [u, pathIndices];
            u = prev(u);
        end
    end
end