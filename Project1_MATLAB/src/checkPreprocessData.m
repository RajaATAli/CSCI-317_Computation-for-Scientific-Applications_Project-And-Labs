function imgOut = checkPreprocessData(img)
    imgOut = preprocessData(img); % Apply your preprocessing steps
    % Display the size of each preprocessed image to debug
    disp(['Processed image size: ', mat2str(size(imgOut))]);
end
