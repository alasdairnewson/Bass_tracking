


function[imgOut] = create_2D_plane(H,bgImg,maxX,maxY)

    imgSize = size(bgImg);

    discreteFloorStep = 0.01;
    [gridX,gridY] = meshgrid(0:discreteFloorStep:maxX,0:discreteFloorStep:maxY);
    originalCoords = [gridX(:)';gridY(:)'; ones(1,numel(gridX))];
    transformedCoords = inv(H)*originalCoords;
    transformedCoords = transformedCoords./(repmat(transformedCoords(3,:),[3 1]));

    tranformedInds = sub2ind(imgSize,min(max(round(transformedCoords(2,:)),1),imgSize(1)) , ...
        min(max( round(transformedCoords(1,:)),1),imgSize(2)) );
    imgOut = reshape(bgImg(tranformedInds),size(gridY));

end