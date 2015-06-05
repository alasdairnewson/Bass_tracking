

function[frameOut,trackingData] = track_objects(frameIn,fgImg,trackingData)

    %retrieve tracking data
    tracks = trackingData.tracks;
    nextId = trackingData.nextId;

    [centroids,bboxes] = detectObjects(fgImg,trackingData);
    tracks = predictNewLocationsOfTracks(tracks);
    
    [assignments, unassignedTracks, unassignedDetections] = ...
        detectionToTrackAssignment(tracks,centroids);

    tracks = updateAssignedTracks(assignments,tracks,centroids,bboxes);
    tracks = updateUnassignedTracks(tracks,unassignedTracks);
    tracks = deleteLostTracks(tracks);
    [tracks,nextId] = createNewTracks(centroids,bboxes,tracks,unassignedDetections,nextId);

    frameOut = displayTrackingResults(frameIn,fgImg,tracks);

    %set data in tracking
    trackingData.tracks = tracks;
    trackingData.nextId = nextId;
end