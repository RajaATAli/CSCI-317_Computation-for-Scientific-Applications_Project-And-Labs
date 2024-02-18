function testModel(model, testData)
    % Evaluating the model using TEST dataset
    predictedLabels = classify(model, testData);
    actualLabels = testData.Labels;
    
    % Calculating accuracy on TEST datast
    % comparing the predicted labels to the actual labels and calculating 
    % the proportion of correct predictions
    accuracy = sum(predictedLabels == actualLabels) / numel(actualLabels);
    disp(['Accuracy: ', num2str(accuracy)]);
    
    % Confusion matrix - showing how many predictions are correct versus
    % incorrect for each class
    figure;
    confusionchart(actualLabels, predictedLabels);
    saveas(gcf, '../results/confusionMatrix.png'); % Save the confusion matrix as png to results directoru
    title('Confusion Matrix');
    
    % Calculate additional performance metrics
    [confMat,order] = confusionmat(actualLabels, predictedLabels);
    
    % Precision, Recall, and F1 Score
    for i=1:size(confMat,1)
        precision(i) = confMat(i,i) / sum(confMat(:,i));
        recall(i) = confMat(i,i) / sum(confMat(i,:));
        f1Score(i) = 2 * ((precision(i)*recall(i)) / (precision(i) + recall(i)));
    end
    
    % Precision-Recall Curve - shows the trade-off between precision and recall
    % for different thresholds
    figure;
    plot(recall, precision, '-o');
    xlabel('Recall');
    ylabel('Precision');
    title('Precision-Recall Curve');
    grid on;
    saveas(gcf, '../results/precisionRecallCurve.png');

   
 
    % Accuracy vs. Label Frequency Graph - compares the accuracy of each
    % class against its frequency in the dataset
    labelCounts = countcats(actualLabels);
    labelAccuracy = zeros(length(order),1);
    for i = 1:length(order)
        labelAccuracy(i) = confMat(i,i) / sum(confMat(i,:));
    end
    figure;
    yyaxis left;
    bar(labelCounts);
    ylabel('Frequency');
    yyaxis right;
    plot(labelAccuracy, '-o', 'LineWidth',2, 'MarkerSize',10);
    ylabel('Accuracy');
    xlabel('Labels');
    set(gca, 'xticklabels', order);
    title('Accuracy vs. Label Frequency');
    grid on;
    legend('Frequency', 'Accuracy', 'Location', 'best');
    saveas(gcf, '../results/accuracyVsLabelFrequency.png');


    % Visualization of some classified images (predicted and actual labels)
    uniqueLabels = unique(actualLabels);
    numLabelsToVisualizePerCategory = 5; 
    
    for label = uniqueLabels'
        idxs = find(actualLabels == label, numLabelsToVisualizePerCategory, 'first');
        for idx = idxs'
            img = readimage(testData, idx);
            actualLabel = actualLabels(idx);
            predictedLabel = predictedLabels(idx);
            
            figure;
            imshow(img);
            title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]);
            saveas(gcf, sprintf('../results/classifiedImage_%d_%s.png', idx, char(predictedLabel)));
        end
    end
end
