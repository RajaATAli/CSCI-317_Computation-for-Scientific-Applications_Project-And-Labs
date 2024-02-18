% preprocessVideo.m
function preprocessVideo(videoDevice, detector, classificationModel)
    figure; % Create a figure for displaying video frames
    while true
        frame = snapshot(videoDevice); % Capture a frame from the webcam
        
        % Detect objects using YOLO v3 object detector
        [bboxes, scores, labels] = detect(detector, frame);
        
        for i = 1:size(bboxes,1)
            croppedImage = imcrop(frame, bboxes(i,:)); % Crop detected object
            processedImage = preprocessData(croppedImage); % Preprocess image
            [label, score] = classify(classificationModel, processedImage); % Classify object
            frame = insertObjectAnnotation(frame, 'rectangle', bboxes(i,:), string(label)); % Annotate frame
        end
        
        imshow(frame); % Display the frame
        pause(0.05); % Short pause
    end
end


