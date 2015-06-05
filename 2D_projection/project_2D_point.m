

function[imgOut] = project_2D_point(H,img2D,posY,posX)

    pointSize = 10;
    discreteFloorStep = 0.01;

    transformedPos = H*[posX;posY;1];
    transformedPos = transformedPos./transformedPos(3);
    trackedPos(1) = round((1/discreteFloorStep)*transformedPos(1));
    trackedPos(2) = round((1/discreteFloorStep)*transformedPos(2));
    
    %put a marker where the person is
    imgOut = repmat(img2D,[1 1 3]);
    imgOut( max(trackedPos(2)-pointSize,1):min(trackedPos(2)+pointSize,size(img2D,1)) , ...
        max(trackedPos(1)-pointSize,1):min(trackedPos(1)+3,size(img2D,2)),1 ) = 0;
    imgOut( max(trackedPos(2)-pointSize,1):min(trackedPos(2)+pointSize,size(img2D,1)) , ...
        max(trackedPos(1)-pointSize,1):min(trackedPos(1)+3,size(img2D,2)),3 ) = 0;
    imgOut( max(trackedPos(2)-pointSize,1):min(trackedPos(2)+pointSize,size(img2D,1)) , ...
        max(trackedPos(1)-pointSize,1):min(trackedPos(1)+pointSize,size(img2D,2)),2 ) = 255;


end