function [trainData, testData] = loadData(datasetDir)
    % Define paths to the training and test datasets
    trainDir = fullfile(datasetDir, 'TRAIN');
    testDir = fullfile(datasetDir, 'TEST');
    
    % Use imageDatastore to load images and their labels, with
    % preprocessing for debugging purposes
    trainData = imageDatastore(trainDir, ...
        'IncludeSubfolders', true, 'LabelSource', 'foldernames', ...
        'ReadFcn', @(filename)checkPreprocessData(imread(filename)));
    testData = imageDatastore(testDir, ...
        'IncludeSubfolders', true, 'LabelSource', 'foldernames', ...
        'ReadFcn', @(filename)checkPreprocessData(imread(filename)));
end



