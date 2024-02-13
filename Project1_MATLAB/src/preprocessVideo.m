function preprocessVideo(videoDevice, model)
    figure; % Create a new figure for displaying video frames
    while true
        frame = snapshot(videoDevice); % Capture one frame from webcam
        processedFrame = preprocessData(frame); % Apply preprocessing defined earlier
        
        % Use the model to classify the processed frame
        label = classifyObjects(processedFrame, model);
        
        % Display the frame
        imshow(frame);
        hold on; % Hold on to overlay graphics on the image
        
        % Optional: Highlight the frame or add text based on the label
        if strcmp(char(label), 'Recyclable')
            rectangle('Position', [0, 0, size(frame, 2), size(frame, 1)], 'EdgeColor', 'g', 'LineWidth', 2);
            text(10, 20, char(label), 'Color', 'green', 'FontSize', 12, 'FontWeight', 'bold');
        else % Non-recyclable or other categories
            rectangle('Position', [0, 0, size(frame, 2), size(frame, 1)], 'EdgeColor', 'r', 'LineWidth', 2);
            text(10, 20, char(label), 'Color', 'red', 'FontSize', 12, 'FontWeight', 'bold');
        end
        
        hold off; % Release the hold to update the figure with the next frame
        
        % Break the loop with a condition or key press if necessary
        pause(0.05); % Small pause to limit the speed of execution
    end
end


