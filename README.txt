Author: Alasdair Newson
Institution : Duke University
Date : 18 June 2015

*****************************************

This README file describes how to use the foreground tracking code which is downloaded from this url :

https://github.com/alasdairnewson/Bass_tracking

The goal of the code is to track a person's position on a 2D plane (the floor), using a camera or webcam connected to the computer.

This code has the following functionalities :

- It accesses a camera or webcam installed on the computer via Matlab
- It estimates the 'background' in a camera's point of view
- It estimates the projection from the 2D plane of the floor to the camera's viewpoint


*****************************************
**********    DEMO PARAMETERS   *********
*****************************************

Before running anything else, look at the 'set_demo_parameters.m' file. This creates a 'demo_parameters.mat' file which contains the parameters of the current demo. These include :

- fileName : The name which you would like to give to your project. This allows you to store the models of several projects in the 'models/' directory. The default name is 'office'.
- videoInputName : the driver used by Matlab to access cameras and webcams. See below 'ACCESSING A CAMERA' for details.
- videoInputId : the numeric ID of the camera/webcam which you want to access. This is needed because several cameras can be accessed by one driver. The default value is 1.
- resizeScale : A scalar indicating the fraction by which we resize the input video stream, in the x and y directions. This is done in order to speed up calculations, since there is no real need to have extremely high definition for the tracking.

Change the project name (fileName) to whatever you wish, and run the file by typing:

>> set_demo_parameters 

*****************************************
*******    ACCESSING A CAMERA   *********
*****************************************

To use the camera via Matlab, the code accesses it with the 'videoinput' command. To do this, you need to have a driver installed in Matlab which can access cameras. If no driver is available, you will get an error like this one : 

Error using videoinput (line 217)
Invalid ADAPTORNAME specified. Type 'imaqhwinfo' for a list of available
ADAPTORNAMEs. Image acquisition adaptors may be available as downloadable
support packages. Open Support Package Installer to install additional
vendors.

If this is the case, then you must intall one by clicking on the 'Open Support Package Installer' link. This will open up the installer. You must find which package to install, based on your camera. Here are some tips based on the author's experience :

- Install 'OS Generic Video Interface'
- You can find out how many cameras are available using this driver with :
>> imaqhwinfo('macvideo')
- Once you have done this you should be able to access your cameras with :
>> vidIn = videoinput('macvideo',deviceId);

If you installed a different driver than 'macvideo', then change the 'videoInputName' in the 'set_demo_parameters' file and run it again.

IMPORTANT !!!

Matlab is sensitive when using the cameras. If you get a message like this :

Error using imaqdevice/start (line 95)
Multiple image acquisition objects cannot access the same device
simultaneously.

then just restart matlab. This error is due to the fact that the camera structure 'vidObj' in Matlab must be properly closed with :

>> delete(vidObj);


*****************************************
*****    CAMERA VIEW CALIBRATION   ******
*****************************************

In order to accurately represent the position of a person on the 2D floor, we need to estimate the projection necessary to go from pixel coordinates (in the camera's viewpoint), to the floor's (real-world) coordinates. This is done by estimating a plane-to-plane homography (a geometric projection). In order to do this, 4 points are (mathematically) necessary, and also their 'real-world' coordinates in the 2D floor plane. 

In this code, we implement this in the following manner :

- Run calibrate_ground.m
- The code takes a picture using the input camera.
- The user must click on four points which correspond to a RECTANGLE on the 2D floor
- When four points are clicked, right-click to finish
- The command line then asks the length (distance) of the sides of the rectangle in the x and y directions
- The code saves the homography to the 'models' directory, using the project name of 'demo_parameters'

IMPORTANT !!

You must specify the rectangle starting from the top-left corner, and continuing in the counter-clockwise direction. So you must specify the points in the following order :

- Top-left
- Bottom-left
- Bottom-right
- Top-right


*****************************************
*******    BACKGROUND ESTIMATION   ******
*****************************************

In order to detect the foreground, we must have an estimation of the background. In this code, this is done in a very simple way.

- Run 'set_background_model.m'
- Wait at least 2 seconds.
- The code will estimate the background as the average of the 'nTraingingFrames' last frames
- The code shows the current estimate of the background in a window
- When you are satisfied with the background estimation, close the window


*****************************************
*******     FOREGROUND TRACKING    ******
*****************************************

You are now ready to run the foreground detection code !! Just type :

>> tracking_demo

You will see the current image, the detected foreground, the tracked objects, and finally the projection of one of the tracked objects onto the 2D plane