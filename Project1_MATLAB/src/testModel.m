function testModel(model, testData)
    % Evaluating the model
    predictedLabels = classify(model, testData);
    actualLabels = testData.Labels;
    
    % Calculating accuracy
    accuracy = sum(predictedLabels == actualLabels) / numel(actualLabels);
    disp(['Accuracy: ', num2str(accuracy)]);
    
    % Confusion matrix
    figure;
    confusionchart(actualLabels, predictedLabels);
    
     % Ensure visualization includes both categories
    uniqueLabels = unique(actualLabels);
    numLabelsToVisualizePerCategory = 5; % Adjust as needed to ensure balance
    
    for label = uniqueLabels'
        idxs = find(actualLabels == label, numLabelsToVisualizePerCategory, 'first');
        for idx = idxs'
            img = readimage(testData, idx);
            actualLabel = actualLabels(idx);
            predictedLabel = predictedLabels(idx);
            
            figure;
            imshow(img);
            title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]);
        end
    end
end