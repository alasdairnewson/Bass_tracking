

function [centroids,bboxes] = detectObjects(fgImg,trackingData)

    % Perform blob analysis to find connected components.
    [~, centroids, bboxes] = trackingData.trackingObj.blobAnalyser.step(fgImg);
end