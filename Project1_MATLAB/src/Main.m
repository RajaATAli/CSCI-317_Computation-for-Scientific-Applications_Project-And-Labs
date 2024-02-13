% --------------------------------------
% Author: Raja Allmdar Tariq Ali
% Date: 02/18/24
% --------------------------------------
% Object Detection and Classification Project to sort projects into either
% waste or recycling

% Clearing the workspace and console
% Main.m - Main script to run the object detection and classification project.

clear; close all; clc;

% Add paths to the utility functions and datasets if necessary
datasetPath = '../DATASET/'; % Path to the dataset directory relative to 'src'
modelsPath = '../models/'; % Path to save/load models

% Load and preprocess dataset
disp('Loading and preprocessing data...');
[trainData, testData] = loadData(datasetPath);
% Augment data if necessary
% trainData = augmentData(trainData);

% Train the model
disp('Training the model...');
%model = trainModel(trainData, testData);

% Save the trained model for later use
% save('../models/trainedModel.mat', 'model');

% Assuming the model has already been trained and saved
disp('Loading the trained model...');
model = load('../models/trainedModel.mat', 'model');
model = model.model; % Ensure the model variable is correctly extracted

% Test the model
disp('Testing the model...');
testModel(model, testData); % This function should also calculate and display performance metrics

% Optional: Real-time video processing setup
disp('Setting up real-time video processing...');
videoDevice = webcam; % Requires the Webcam Support Package

% Assuming the model has already been trained, loaded, and is ready
disp('Starting real-time classification...');
preprocessVideo(videoDevice, model);

% Remember to release the webcam after use
clear('videoDevice');


disp('Project execution completed.');
