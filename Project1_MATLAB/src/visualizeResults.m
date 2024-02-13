function visualizeResults(model, testData)
    for i = 1:10 % Visualize first 10 predictions
        [img,info] = read(testData);
        actualLabel = info.Label;
        predictedLabel = classify(model, img);
        
        figure;
        imshow(img);
        title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)]);
    end
end
