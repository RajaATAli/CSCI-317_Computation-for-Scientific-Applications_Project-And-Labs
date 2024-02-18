function imgOut = preprocessData(img)
    % Resize image input to 224x224 pixels
    % We need a equal size of images to train the model
    imgOut = imresize(img, [224 224]);

    % Ensure image is in RGB - requirement for CNN model
    if size(imgOut, 3) == 1
        imgOut = repmat(imgOut, [1 1 3]);
    end

    % Normalize pixel values (for RGB, this step is applied per channel)
    % Necessary for better performance in deep learning models
    imgOut = double(imgOut) / 255;
end

%checkPreprocessData.m

% This function was added as a debugging step as I was getting an error
% regarding image size when training the model
% The trained model (CNNs) require a fixed size input

%function imgOut = checkPreprocessData(img)
 %   imgOut = preprocessData(img); % Apply preprocessing steps
    % Display the size of each preprocessed image to debug
  %  disp(['Processed image size: ', mat2str(size(imgOut))]);
% end

