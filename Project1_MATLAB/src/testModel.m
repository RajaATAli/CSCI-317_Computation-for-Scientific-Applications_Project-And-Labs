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
    saveas(gcf, '../results/confusionMatrix.png');
    title('Confusion Matrix');
    
    % Calculate additional performance metrics
    [confMat,order] = confusionmat(actualLabels, predictedLabels);
    
    % Precision, Recall, and F1 Score
    for i=1:size(confMat,1)
        precision(i) = confMat(i,i) / sum(confMat(:,i));
        recall(i) = confMat(i,i) / sum(confMat(i,:));
        f1Score(i) = 2 * ((precision(i)*recall(i)) / (precision(i) + recall(i)));
    end
    
    % Precision-Recall Curve
    figure;
    plot(recall, precision, '-o');
    xlabel('Recall');
    ylabel('Precision');
    title('Precision-Recall Curve');
    grid on;
    saveas(gcf, '../results/precisionRecallCurve.png');

   

    % Accuracy vs. Label Frequency Graph
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



    % Visualization of some classified images
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
            saveas(gcf, sprintf('../results/classifiedImage_%d_%s.png', idx, char(predictedLabel)));
        end
    end
end
