function processedImage = preprocessForClassification(croppedImage)
    processedImage = imresize(croppedImage, [224 224]); % Resize image
    processedImage = double(processedImage) / 255; % Normalize image
end
