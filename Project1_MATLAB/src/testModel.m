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

     % Visualize first 10 predictions
    for i = 1:min(10, numel(actualLabels)) % Ensure it doesn't exceed available data
        img = readimage(testData, i);
        actualLabel = actualLabels(i);
        predictedLabel = predictedLabels(i);
        
        figure;
        imshow(img);
        title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]);
    end
end
