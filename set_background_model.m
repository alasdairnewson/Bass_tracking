
clear all;
hFigure = figure;
fileName = 'office';
load('demo_parameters.mat');

%dbstop in create_background_model at 8

NumberFrameDisplayPerSecond = 10;

%initialise video feed
vidObj = videoinput('macvideo');
set(vidObj,'FramesPerTrigger',1);
% Go on forever until stopped
set(vidObj,'TriggerRepeat',Inf);
% Get a grayscale image
set(vidObj,'ReturnedColorSpace','rgb');
triggerconfig(vidObj, 'Manual');

% set up timer object
TimerData=timer('TimerFcn', {@background_model,vidObj,demoParameters},'Period',1/NumberFrameDisplayPerSecond,...
    'ExecutionMode','fixedRate','BusyMode','drop');

% Start video and timer object
start(vidObj);
start(TimerData);

% We go on until the figure is closed
uiwait(hFigure);

% Clean up everything
stop(TimerData);
delete(TimerData);
stop(vidObj);
delete(vidObj);
% clear persistent variables
clear functions;
