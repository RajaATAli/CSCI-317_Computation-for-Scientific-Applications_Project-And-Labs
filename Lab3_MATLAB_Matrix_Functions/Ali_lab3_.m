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

fprintf('Welcome to Ontario Pathfinder!\n');
fprintf('Below are the cities available for your journey:\n\n');

% Loop through the cityNames array and display each city
for i = 1:length(cityNames)
    fprintf('%d. %s\n', i, cityNames{i});
end

fprintf('\nPlease enter the names of your start and end cities exactly as shown above.\n');



% Prompt user for start and end cities
startCityName = input('Enter the name of the start city: ', 's');
endCityName = input('Enter the name of the end city: ', 's');

% Convert city names to indices
startCity = cityMap(startCityName);
endCity = cityMap(endCityName);


% Call the Dijkstra's algorithm function with the distance matrix and city indices
[shortestDistance, pathIndices] = dijkstraAlgorithm(distances, startCity, endCity);

% Convert path indices back to city names
pathNames = cityNames(pathIndices);


% Display the shortest distance and the path to the user
% Display the shortest distance
fprintf('\nThe shortest distance from %s to %s is: %.2f km\n', startCityName, endCityName, shortestDistance);

% Display the path
fprintf('Path: %s\n', strjoin(pathNames, ' -> '));


% User-Defined function for Dijkstra's algorithm
% Implement Dijkstra's algorithm here
% Output the shortest distance and the path taken
function [shortestDistance, pathIndices] = dijkstraAlgorithm(distMatrix, startCity, endCity)
    numCities = size(distMatrix, 1);
    visited = false(1, numCities);
    distance = inf(1, numCities);
    prev = -ones(1, numCities); % Initialize with -1 for no predecessor
    
    distance(startCity) = 0;
    
    for i = 1:numCities
        % Find the unvisited node with the smallest distance
        minDistance = inf;
        u = -1;
        for j = 1:numCities
            if ~visited(j) && distance(j) <= minDistance
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
        shortestDistance = distance(endCity);
        pathIndices = [];
        u = endCity;
        while u ~= -1
            pathIndices = [u, pathIndices];
            u = prev(u);
        end
    end
end