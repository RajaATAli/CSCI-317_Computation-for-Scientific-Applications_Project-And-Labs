function evaluateModel(model, testData)
    predictedLabels = classify(model, testData);
    actualLabels = testData.Labels;
    
    % Calculate accuracy
    accuracy = sum(predictedLabels == actualLabels) / numel(actualLabels);
    disp(['Accuracy: ', num2str(accuracy)]);
    
    % Confusion matrix
    figure;
    confusionchart(actualLabels, predictedLabels);
end
