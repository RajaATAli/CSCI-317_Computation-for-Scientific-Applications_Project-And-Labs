function [trainData, testData] = loadData(datasetDir)
    % Define paths to the training and test datasets
    % `fullfile` function combines the base dataset directory with the
    % TRAIN and TEST subdirectories
    trainDir = fullfile(datasetDir, 'TRAIN');
    testDir = fullfile(datasetDir, 'TEST');
    
    % Use imageDatastore to load images and their labels, with
    % preprocessing (preprocessData.m)
    % 'imageDatastore' automatically labels the images based on folder
    % names

    % Here, we are loading the training dataset
    trainData = imageDatastore(trainDir, ...
        'IncludeSubfolders', true, 'LabelSource', 'foldernames', ...
        'ReadFcn', @(filename)preprocessData(imread(filename)));

    % Now, we will load the testing dataset
    testData = imageDatastore(testDir, ...
        'IncludeSubfolders', true, 'LabelSource', 'foldernames', ...
        'ReadFcn', @(filename)preprocessData(imread(filename)));
end



