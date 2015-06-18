

%function to create demo parameters
clear demoParameters;

demoParameters.fileName = 'office';
demoParameters.resizeScale = 1/3;
demoParameters.videoInputName = 'macvideo';
demoParameters.videoInputId = 1;
save('demo_parameters.mat','demoParameters');