function [bboxes, scores, labels] = detectObjects(frame, detector)
    [bboxes, scores, labels] = detect(detector, frame);
    % Here, 'detector' is a pre-trained object detector model,
    % which you would load or define elsewhere in your project.
end
