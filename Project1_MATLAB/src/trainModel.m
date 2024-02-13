function model = trainModel(trainData, testData)
    layers = [
        imageInputLayer([224 224 3]) % Adjust size according to your preprocessing
        convolution2dLayer(3, 8, 'Padding','same')
        batchNormalizationLayer
        reluLayer   
        maxPooling2dLayer(2, 'Stride', 2)
        convolution2dLayer(3, 16, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer
        maxPooling2dLayer(2, 'Stride',2)
        convolution2dLayer(3, 32, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer
        fullyConnectedLayer(2) % Assuming two classes: Recyclable (R) and Organic (O)
        softmaxLayer
        classificationLayer];

    options = trainingOptions('sgdm', ...
        'InitialLearnRate',0.01, ...
        'MaxEpochs',10, ...
        'Shuffle','every-epoch', ...
        'ValidationData',testData, ...
        'ValidationFrequency',30, ...
        'Verbose',false, ...
        'Plots','training-progress');
    
    model = trainNetwork(trainData, layers, options);
end
