function [bboxes, scores, labels] = detectObjects(frame, detector)
    [bboxes, scores, labels] = detect(detector, frame);
    % Here, 'detector' is a pre-trained object detector model,
    % Will be define elsewhere in project
end
