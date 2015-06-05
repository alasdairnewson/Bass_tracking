

    
close all;
clear all;
load('demo_parameters.mat');

fileName = demoParameters.fileName;

vidObj = videoinput('macvideo');
set(vidObj,'ReturnedColorSpace','rgb');
%get 
frame = imresize(getsnapshot(vidObj),demoParameters.resizeScale);
delete(vidObj);

figure;imshow(frame);
imgSize = size(frame);

%get first vanishing line, on the y axis, of distance q from the origin
[lineX1,lineY1] = getline();
lineX1 = min(max(round(lineX1),0),imgSize(2));
lineX1 = lineX1(1:2);
lineY1 = min(max(round(lineY1),0),imgSize(1));
lineY1 = lineY1(1:2);

%get second point on the x axis, at r distance from the origin
[lineX2,lineY2] = getline();
lineX2 = min(max(round(lineX2),0),imgSize(2));
lineX2 = lineX2(1:2);
lineY2 = min(max(round(lineY2),0),imgSize(1));
lineY2 = lineY2(1:2);

xDistance = input('Please indicate the distance on the x axis : ');
yDistance = input('Please indicate the distance on the y axis : ');

landmarks = [lineX1 lineY1; lineX2 lineY2];
distances = [xDistance;yDistance];

[H] = estimate_homography(landmarks,[0 0; 0 distances(2);distances(1) 0;distances(1) distances(2)]);

%now show the transformed coordinate system
[gridX,gridY] = meshgrid(1:imgSize(2),1:imgSize(1));

originalCoords = [gridX(:)';gridY(:)'; ones(1,numel(gridX))];

transformedCoords = H*originalCoords;
%normalise the coordinates with respect to the last row
transformedCoords = transformedCoords./(repmat(transformedCoords(3,:),[3 1]));

% %     transformedCoords = transformedCoords(1:2,:);
% %     transformedCoordsX = reshape(transformedCoords(1,:),imgSize);
% %     transformedCoordsY = reshape(transformedCoords(2,:),imgSize);
%figure;imshow(transformedCoordsX,[]);
%figure;imshow(transformedCoordsY,[]);

%save the homography
if (~exist('models','dir'))
    mkdir('models');
end
save(['models/' fileName '_homography.mat'],'H');

demoParameters.xDistance = 20;
demoParameters.yDistance = 10;

save('demo_parameters.mat','demoParameters');
    