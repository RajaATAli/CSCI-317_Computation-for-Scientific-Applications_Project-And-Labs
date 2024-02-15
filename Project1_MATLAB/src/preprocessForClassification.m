% preprocessForClassification.m
function processedImage = preprocessForClassification(croppedImage)
    % Example preprocessing steps
    processedImage = imresize(croppedImage, [224 224]); % Resize image
    processedImage = double(processedImage) / 255; % Normalize image
end
