% It took approximately 72 minutes to train the model on my M1 MacBook Air
% My laptop heated up - recommend using cloud-based platforms or
% supercomputer(s) to train model in the future

function model = trainModel(trainData, testData)
    % Defining the architecture of the CNN
    % Image input layer - must match dimension during preprocessing
    layers = [
        imageInputLayer([224 224 3]) % Images must be 224x224x3 (RGB)
        % Adding the first convolutional layer
        convolution2dLayer(3, 8, 'Padding','same')
        % Including batch normalization to stabilize learning
        batchNormalizationLayer
        % Introduce non linearirty into the model
        reluLayer   
        % prevent overfitting -> reduce spatial dimensions
        maxPooling2dLayer(2, 'Stride', 2)
        % Repeat the pattern to detect more complex patterns
        convolution2dLayer(3, 16, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer
        maxPooling2dLayer(2, 'Stride',2)
        convolution2dLayer(3, 32, 'Padding', 'same')
        batchNormalizationLayer
        reluLayer
        fullyConnectedLayer(2) % two classes: Recyclable (R) and Organic (O)
        % Convert the output into probability scores for each class
        softmaxLayer
        % Classification layer -> cross-entropy loss for training
        classificationLayer];
    

    % Specifying the training options
    % tochastic gradient descent with momentum is used -> common
    % optimization algo for deep learning networks
    options = trainingOptions('sgdm', ...
        'InitialLearnRate',0.01, ...
        'MaxEpochs',10, ...
        'Shuffle','every-epoch', ...
        'ValidationData',testData, ...
        'ValidationFrequency',30, ...
        'Verbose',false, ...
        'Plots','training-progress');
    
    % Training the model
    model = trainNetwork(trainData, layers, options);
end
