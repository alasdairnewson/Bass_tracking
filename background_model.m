function background_model(obj, event,vid,demoParameters)
    persistent imgIn;
    persistent bgModel;
    persistent nFrames;
    persistent handlesRaw;
    persistent handlesGrad;
    trigger(vid);
    imgIn=imresize(getdata(vid,1,'uint8'),demoParameters.resizeScale);
    fileName = demoParameters.fileName;
    
    nTraingingFrames = 10;

    if isempty(handlesRaw)
       % if first execution, we create the figure objects
       subplot(2,1,1);
       handlesRaw=imshow(imgIn);
       title('CurrentImage');
       
       %initialise the frame number
       nFrames = 1;

       % show gradient magnitude
       subplot(2,1,2);
       bgModel = zeros([size(imgIn) nTraingingFrames]);
       bgModel(:,:,:,1) = double(imgIn);
       handlesGrad=imshow(uint8(round(mean(bgModel,4))));
       title('Estimated background');
    else
        nFrames = nFrames+1;
        set(handlesRaw,'CData',imgIn);
        bgModel = circshift(bgModel,[0 0 0 1]);
        bgModel(:,:,:,1) = double(imgIn);
        set(handlesGrad,'CData',uint8(round(mean(bgModel,4))));
        bgModelOut = uint8(round(mean(bgModel,4)));
        save(['models/' fileName '_background_model.mat'],'bgModelOut');
    end
end