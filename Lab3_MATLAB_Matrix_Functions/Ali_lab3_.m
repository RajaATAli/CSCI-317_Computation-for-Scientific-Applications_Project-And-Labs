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
function [shortestDistance, path] = dijkstraAlgorithm(distMatrix, startCity, endCity)


    % Initialize variables to keep track of visited nodes, the shortest
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
    distance = inf(1,numCities);

    % previous tracks the previous node in the optimal path from start city
    previous = -ones(1,numCities)


    % Setting the distance of the start city to 0
    distance(startCity) = 0;

    % Using a nested for loop to iteratively update the shortest path from
    % the source node to all other nodes in the graph
    % Key Concept (Relaxation):
    % * if (d[u] + c(u,v) < d[v])
    %       d[v] = d[u] + c(u,v)

    % Iterating over all cities/nodes
    for i = 1:numCities
        % Finding the unvisited node with the minimum distance
        [~, u] = min(distance + visited * max(distance));
        % Marking the selected node as visited
        visited(u) = true;

        % Inner loop to explore the neighbours of u
        for v = 1:numCities
            % Condition to checked unvisited neighbors and +ve distances
            if ~visited(v) && distMatrix(u,v) > 0
                % Now, calculate the alt distance path accordingly
                alt = distance(u) + distMatrix(u, v);
                % If the new distance (alt) is shorter than the current
                % known shortest distance to v then update to this new
                % shorter distance and set u as the predecessor of v
                if alt < distance(v)
                    distance(v) = alt;
                    previous(v) = u;
                end
            end
        end
    end

    % Now, reconstruct the shortest path in reverse order by following
    % previous array from the end city back to the start city

    shortestDistance = distance(endCity);
    path = [];
    while endCity ~= -1
        path = [endCity path];
        endCity = previous(endCity);

    end
end
