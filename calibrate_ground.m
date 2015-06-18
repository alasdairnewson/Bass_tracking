

    
close all;
addpath('2D_projection');
load('demo_parameters.mat');


fileName = demoParameters.fileName;

vidObj = videoinput(demoParameters.videoInputName,demoParameters.videoInputId);
set(vidObj,'ReturnedColorSpace','rgb');
%get 
frame = imresize(getsnapshot(vidObj),demoParameters.resizeScale);
delete(vidObj);

figure;imshow(frame);
imgSize = size(frame);

%get the rectangle on the floor, starting from the (0,0) point
[ptsX,ptsY] = getline();
if(numel(ptsX)<4 || numel(ptsY)<4)
    error('Error, the homography estimation needs 4 points.');
end
ptsX = min(max(round(ptsX(1:4)),0),imgSize(2));
ptsY = min(max(round(ptsY(1:4)),0),imgSize(1));

xDistance = input('Please indicate the distance on the x axis : ');
yDistance = input('Please indicate the distance on the y axis : ');

landmarks = [ptsX ptsY];
distances = [xDistance;yDistance];

%real-world coordinates of the rectangle (in [x,y]):
% [0 0 (top left); 0 yDistance (bottom left); xDistance yDistance (bottom right); yDistance 0 (top right)]
H = estimate_homography(landmarks,[0 0; 0 distances(2);distances(1) distances(2);distances(1) 0]);

%save the homography
if (~exist('models','dir'))
    mkdir('models');
end
save(['models/' fileName '_homography.mat'],'H');

demoParameters.xDistance = xDistance;
demoParameters.yDistance = yDistance;

save('demo_parameters.mat','demoParameters');
    