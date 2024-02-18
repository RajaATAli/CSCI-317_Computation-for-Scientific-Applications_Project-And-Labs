% This function was added as a debugging step as I was getting an error
% regarding image size when training the model
% The trained model (CNNs) require a fixed size input

function imgOut = checkPreprocessData(img)
    imgOut = preprocessData(img); % Apply preprocessing steps
    % Display the size of each preprocessed image to debug
    disp(['Processed image size: ', mat2str(size(imgOut))]);
end
