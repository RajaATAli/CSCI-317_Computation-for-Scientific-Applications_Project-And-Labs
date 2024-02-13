function label = classifyObjects(processedImage, model)
    % Assuming 'model' is already loaded and 'processedImage' is ready
    label = classify(model, processedImage);
    disp(['Predicted Label: ', char(label)]);
end

