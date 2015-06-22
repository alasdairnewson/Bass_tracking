
close all;
clear all;
addpath('tracking');
addpath('2D_projection');

load('demo_parameters.mat');

hFigure = figure;

%dbstop in foreground_tracking at 75;

NumberFrameDisplayPerSecond = 10;

%initialise video feed
vidObj = videoinput(demoParameters.videoInputName,demoParameters.videoInputId);
set(vidObj,'FramesPerTrigger',1);
% Go on forever until stopped
set(vidObj,'TriggerRepeat',Inf);
% Get a grayscale image
set(vidObj,'ReturnedColorSpace','rgb');
triggerconfig(vidObj, 'Manual');

% set up timer object
TimerData=timer('TimerFcn', {@foreground_tracking,vidObj,demoParameters},'Period',1/NumberFrameDisplayPerSecond,...
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
