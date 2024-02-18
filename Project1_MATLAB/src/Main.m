% --------------------------------------
% Author: Raja Allmdar Tariq Ali
% Date: 02/18/24
% Major: BS Computer Science
% --------------------------------------
% Problem Description:
% * This project in MATLAB aims to detect and classify objects into either 
% recyclable (R) or organic (O) categories using real-time video processing.
% * It leverages pre-trained object detection models for detecting objects
% and a custom-trained model for classification.

% Clearing the workspace and console
% Main.m - Main script to run the object detection and classification project.

% Clear the MATLAB workspace, close all figures, and clear command window 
% This will ensure a clean start
clear; close all; clc;

% Add paths to the datasets
datasetPath = '../DATASET/'; % Relative path to the dataset directory
modelsPath = '../models/'; % Relative path to where custome trained models are stored

% Load and preprocess dataset for training and testing classification model
% This includes reading the images, applying any necessary preprocessing 
disp('Loading and preprocessing data...');
[trainData, testData] = loadData(datasetPath);

% Train the model
%disp('Training the model...');
%model = trainModel(trainData, testData);

% Save the trained model for later use
% save('../models/trainedModel.mat', 'model');

% Assuming the model has already been trained and saved
%disp('Loading the trained model...');
%model = load('../models/trainedModel.mat', 'model');
%model = model.model; % Ensure the model variable is correctly extracted

% Instead of using the above code, we will use an if statement for checking
% if a model file already exists - more flexible

% Define the path to the model file
modelFilePath = fullfile(modelsPath, 'trainedModel.mat');

% Check if the model file exists
if exist(modelFilePath, 'file')
    % If the model file exists, print a message indicating so
    disp(['A model file exists: ', modelFilePath, '. Model already exists.']);
    
    % Load the trained model since it exists
    disp('Loading the trained model...');
    model = load(modelFilePath, 'model');
    model = model.model; % Extract the model from the loaded structure
else
    % If the model file does not exist, proceed to train the model
    disp('No existing model found. Training the model...');
    model = trainModel(trainData, testData);
    
    Save the newly trained model for later use
    disp(['Saving the trained model to: ', modelFilePath]);
    save(modelFilePath, 'model');
end

% Test the model
disp('Testing the model...');
testModel(model, testData); % This function should also calculate and display performance metrics


% Choose the model
% modelName = 'darknet53-coco'; % or 'darknet53-coco' for the full model
% tiny-yolov3-coco for the minimized model 

% The full object detection model is better for classification but heats up
% your computer (really laggy)
% Therefore, give user (instructor/TA) a choice

% Display information about available models to the user
disp('Select a pre-trained object detection model:');
disp('1: tiny-yolov3-coco - A minimized model, faster but less accurate, suitable for real-time applications on limited hardware (i.e. fast)');
disp('2: darknet53-coco - The full model, more computationally intensive but provides higher accuracy, suitable for applications where detection precision is critical. (i.e. better for the classifcation model but might be slow depending on the hardware you are using');

% Prompt user for model selection
modelChoice = input('Enter the model number (1 or 2): ');

% Determine the model based on user input
switch modelChoice
    case 1
        modelName = 'tiny-yolov3-coco';
        disp('Selected model: tiny-yolov3-coco');
    case 2
        modelName = 'darknet53-coco';
        disp('Selected model: darknet53-coco');
    otherwise
        error('Invalid selection. Please restart and select either 1 or 2.');
end

% Create the YOLO v3 object detector with the chosen model
disp(['Creating the YOLO v3 object detector with the ', modelName, ' model...']);
detector = yolov3ObjectDetector(modelName);


% Real-time video processing setup
disp('Setting up real-time video processing...');
videoDevice = webcam; % Requires the Webcam Support Package


% Assuming the model has already been trained, loaded, and is ready
disp('Starting real-time classification...');
preprocessVideo(videoDevice, detector, model); % Updated to pass the detector as well

% Releasing the webcam after use
clear('videoDevice');


disp('Project execution completed.');
