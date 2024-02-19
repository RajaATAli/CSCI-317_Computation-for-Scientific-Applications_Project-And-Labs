function preprocessVideo(videoDevice, detector, classificationModel)
    fig = figure; % Create a figure for displaying video frames

    % Set a flag to control the loop execution
    keepRunning = true;

    % Define a custom close request function for the figure
    fig.CloseRequestFcn = @stopProcessing;

    % Enter an infinite loop to process video frames in real-time
    while keepRunning
        frame = snapshot(videoDevice); % Capture a frame from the webcam
        
        % Detect objects using YOLO v3 object detector
        [bboxes, scores, labels] = detect(detector, frame);
        
        % Process each detected object in the frame
        for i = 1:size(bboxes,1)
            croppedImage = imcrop(frame, bboxes(i,:)); % Crop detected object
            processedImage = preprocessData(croppedImage); % Preprocess image
            [label, score] = classify(classificationModel, processedImage); % Classify object
            frame = insertObjectAnnotation(frame, 'rectangle', bboxes(i,:), string(label)); % Annotate frame
        end
        
        imshow(frame); % Display the frame
        pause(0.05); % Short pause for display to refresh and for program to process user input
        
        % Check if the figure has been closed
        if ~isvalid(fig)
            break;
        end
    end

    % Define the custom close request function
    function stopProcessing(src, event)
        keepRunning = false;
        delete(fig); % Delete the figure to free up resources
    end
end



