function preprocessVideo(videoDevice, detector, classificationModel)
    figure; % Create a figure for displaying video frames

    % Enter an infinite loop to process video frames in real-time
    while true
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
    end
end


