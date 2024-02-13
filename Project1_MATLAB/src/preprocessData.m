function imgOut = preprocessData(img)
    % Resize image
    imgOut = imresize(img, [224 224]);

    % Ensure image is in RGB
    if size(imgOut, 3) == 1
        imgOut = repmat(imgOut, [1 1 3]);
    end

    % Normalize pixel values (for RGB, this step is applied per channel)
    imgOut = double(imgOut) / 255;
end

